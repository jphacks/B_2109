package mock

import (
	"context"
	"log"

	"github.com/jphacks/B_2109/server/api"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type GoalServer struct {
	api.UnimplementedGoalServer
}

func NewGoalServer() *GoalServer {
	s := GoalServer{}
	return &s
}

func (s GoalServer) CreateGoal(ctx context.Context, r *api.CreateGoalRequest) (*api.CreateGoalResponse, error) {
	return &api.CreateGoalResponse{
		GoalId: 0,
		Time:   timestamppb.Now(),
	}, nil
}

func (s GoalServer) GetByUserID(ctx context.Context, request *api.GetGoalByUserIDRequest) (*api.GetGoalsResponse, error) {
	log.Println("GetByUserID called!")
	return &api.GetGoalsResponse{
		GoalsInfo: []*api.GoalInfo{
			&api.GoalInfo{
				GoalId:            1,
				StartDate:         timestamppb.Now(),
				EndDate:           timestamppb.Now(),
				TimeAmountMinutes: 0,
				NumPages:          0,
				GoalStatus:        0,
				UserId:            0,
			}},
		Time: timestamppb.Now(),
	}, nil
}

func (s GoalServer) UpdateGoalStatus(ctx context.Context, request *api.UpdateGoalStatusRequest) (*api.UpdateGoalResponse, error) {
	return &api.UpdateGoalResponse{
		GoalInfo: nil,
		Time:     timestamppb.Now(),
	}, nil
}
