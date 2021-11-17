package api

import (
	"context"
	"fmt"
	"time"

	"github.com/sirupsen/logrus"

	"github.com/jphacks/B_2109/server/api"
	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type GoalServer struct {
	api.UnimplementedGoalServer
}

func NewGoalServer() *GoalServer {
	return &GoalServer{}
}

func (s GoalServer) CreateGoal(ctx context.Context, r *api.CreateGoalRequest) (*api.CreateGoalResponse, error) {
	g, err := createGoal(ctx, r.GetTime().AsTime(), r.GetNumPages(), uint(r.GetUserId()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "CreateGoal",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}
	return &api.CreateGoalResponse{GoalInfo: constructGoalInfo(g), Time: timestamppb.Now()}, nil
}

func (s GoalServer) GetGoals(ctx context.Context, r *api.GetGoalsRequest) (*api.GetGoalsResponse, error) {
	var gis []*api.GoalInfo

	gs, err := getGoals(ctx, uint(r.GetUserId()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "GetGoals",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}

	for _, g := range gs {
		gi := constructGoalInfo(&g)
		gis = append(gis, gi)
	}
	return &api.GetGoalsResponse{GoalsInfo: gis, Time: timestamppb.Now()}, nil
}

func createGoal(ctx context.Context, time time.Time, pages int64, usrID uint) (*models.Goal, error) {
	start, end := getThisAndNextMonday(time)
	g := models.ConstructGoal(start, end, pages, models.GOAL_STATUS_DOING, usrID)
	gr := repos.NewGoalRepository()
	err := gr.Create(ctx, g)
	if err != nil {
		return nil, err
	}
	return g, nil
}

func getGoals(ctx context.Context, usrID uint) ([]models.Goal, error) {
	gr := repos.NewGoalRepository()
	return gr.GetByUserID(ctx, usrID)
}

func getThisAndNextMonday(current time.Time) (mon, sun time.Time) {
	switch current.Weekday() {
	case time.Monday:
		return current, current.AddDate(0, 0, 7)
	case time.Tuesday:
		return current.AddDate(0, 0, -1), current.AddDate(0, 0, 6)
	case time.Wednesday:
		return current.AddDate(0, 0, -2), current.AddDate(0, 0, 5)
	case time.Thursday:
		return current.AddDate(0, 0, -3), current.AddDate(0, 0, 4)
	case time.Friday:
		return current.AddDate(0, 0, -4), current.AddDate(0, 0, 3)
	case time.Saturday:
		return current.AddDate(0, 0, -5), current.AddDate(0, 0, 2)
	case time.Sunday:
		return current.AddDate(0, 0, -6), current.AddDate(0, 0, 1)
	}
	// not reach here
	return
}

func constructGoalInfo(g *models.Goal) *api.GoalInfo {
	return &api.GoalInfo{
		GoalId:     uint64(g.ID),
		StartDate:  timestamppb.New(g.StartDate),
		EndDate:    timestamppb.New(g.EndDate),
		NumPages:   g.NumPages,
		GoalStatus: translateModelGoalStatus(g.GoalStatus),
		UserId:     uint64(g.UserID),
	}
}

func translateModelGoalStatus(s models.GoalStatus) api.GoalStatus {
	switch s {
	case models.GOAL_STATUS_PENDING:
		return api.GoalStatus_GOAL_PENDING
	case models.GOAL_STATUS_DOING:
		return api.GoalStatus_GOAL_DOING
	case models.GOAL_STATUS_COMPLETE:
		return api.GoalStatus_GOAL_COMPLETE
	case models.GOAL_STATUS_FAILED:
		return api.GoalStatus_GOAL_FAILED
	default:
		return api.GoalStatus_GOAL_UNKNOWN
	}
}
