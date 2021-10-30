package api

import "github.com/jphacks/B_2109/server/api"

type GoalServer struct {
	api.UnimplementedGoalServer
}

func NewGoalServer() *GoalServer {
	s := GoalServer{}
	return &s
}
