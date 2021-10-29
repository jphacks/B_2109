package mock

import (
	"context"

	"google.golang.org/protobuf/types/known/timestamppb"

	"github.com/jphacks/B_2109/server/api"
)

type ReadEventServer struct {
	api.UnimplementedReadEventServer
}

func NewReadEventServer() *ReadEventServer {
	s := ReadEventServer{}
	return &s
}

func (s ReadEventServer) CreateReadEvent(ctx context.Context, r *api.CreateReadEventRequest) (*api.CreateReadEventResponse, error) {
	return &api.CreateReadEventResponse{ReadEventId: uint64(0), Time: timestamppb.Now()}, nil
}

func (s ReadEventServer) GetReadEventsByBookID(ctx context.Context, r *api.GetReadEventsByBookIDRequest) (*api.GetReadEventsResponse, error) {
	return &api.GetReadEventsResponse{ReadEventsInfo: nil, Time: timestamppb.Now()}, nil
}
