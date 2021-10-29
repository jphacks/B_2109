//todo implement
//package api
//
//import (
//	"context"
//	"time"
//
//	"github.com/jphacks/B_2109/server/api"
//	"github.com/jphacks/B_2109/server/pkg/models"
//	"github.com/jphacks/B_2109/server/pkg/repos"
//)
//
//type GoalServer struct {
//	api.UnimplementedGoalServer
//}
//
//func NewGoalServer() *GoalServer {
//	s := GoalServer{}
//	return &s
//}
//
//func (s GoalServer) CreateGoal(ctx context.Context, r *api.CreateGoalRequest) (*api.CreateGoalResponse, error) {
//
//}
//
//func (s GoalServer) GetByUserID(ctx context.Context, r *api.GetGoalByUserIDRequest) (*api.GetGoalsResponse, error) {
//
//}
//
//func (s GoalServer) UpdateGoalStatus(ctx context.Context, r *api.UpdateGoalStatusRequest) (*api.UpdateGoalResponse, error) {
//
//}
//func (s GoalServer) createGoal(ctx context.Context, start, end time.Time, timeAmount int64, pages int64, user uint64) {
//	ur := repos.NewUserRepository()
//	u,err := ur.GetByID(uint(user))
//	if err != nil {
//		re
//
//	}
//	r := repos.NewGoalRepository()
//
//	g := &models.Goal{
//		StartDate:  start,
//		EndDate:    end,
//		TimeAmount: timeAmount,
//		NumPages:   pages,
//		//todo fix
//		GoalStatus: models.GOAL_STATUS_DOING,
//		User:,
//	}
//	r.Create(ctx)
//
//}
