package api

import (
	"context"
	"time"

	"google.golang.org/protobuf/types/known/timestamppb"

	"github.com/jphacks/B_2109/server/api"
	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
)

type ReadEventServer struct {
	api.UnimplementedReadEventServer
}

func NewReadEventServer() *ReadEventServer {
	s := ReadEventServer{}
	return &s
}

func (s ReadEventServer) CreateReadEvent(ctx context.Context, r *api.CreateReadEventRequest) (*api.CreateReadEventResponse, error) {
	re, err := s.createReadEvent(ctx, uint(r.GetBookmarkId()), r.GetReadEventInfo().GetReadStartTime().AsTime(), r.GetReadEventInfo().GetReadEndTime().AsTime(),
		r.GetReadEventInfo().ReadStartWidthRevel, r.GetReadEventInfo().GetReadEndWidthLevel())
	if err != nil {
		return nil, err
	}

	return &api.CreateReadEventResponse{ReadEventId: uint64(re.ID), Time: timestamppb.Now()}, nil
}

func (s ReadEventServer) GetReadEventsByBookID(ctx context.Context, r *api.GetReadEventsByBookIDRequest) (*api.GetReadEventsResponse, error) {
	var ris []*api.ReadEventInfo

	res, err := s.getReadEventsByUserBookID(ctx, uint(r.GetBookId()))
	if err != nil {
		return nil, err
	}
	for _, re := range res {
		ris = append(ris, constructReadEventInfo(&re))
	}

	return &api.GetReadEventsResponse{ReadEventsInfo: ris, Time: timestamppb.Now()}, nil
}

func (s ReadEventServer) createReadEvent(ctx context.Context, bookmark uint, start, end time.Time, startWidth, endWidth int64) (*models.ReadEvent, error) {
	ub, err := getReadingStatusUserBookByBookmarkID(ctx, bookmark)
	if err != nil {
		return nil, err
	}
	re := models.ConstructReadEvent(*ub, start, end, startWidth, endWidth)
	rer := repos.NewReadEventRpository()
	err = rer.Create(ctx, re)
	return re, err
}

func (s ReadEventServer) getReadEventsByUserBookID(ctx context.Context, id uint) ([]models.ReadEvent, error) {
	rer := repos.NewReadEventRpository()
	return rer.GetByUserBookID(ctx, id)
}

func getReadingStatusUserBookByBookmarkID(ctx context.Context, id uint) (*models.UserBook, error) {
	ubr := repos.NewUserBookRepository()
	ubs, err := ubr.GetByBookmarkID(ctx, id)
	if err != nil {
		return nil, err
	}

	for _, ub := range ubs {
		if ub.ReadStatus == models.READ_STATUS_READING {
			return &ub, nil
		}
	}
	return nil, ErrNoReadingUserBook
}

func constructReadEventInfo(r *models.ReadEvent) *api.ReadEventInfo {
	return &api.ReadEventInfo{
		ReadStartTime:       timestamppb.New(r.ReadStartTime),
		ReadEndTime:         timestamppb.New(r.ReadEndTime),
		ReadStartWidthRevel: r.ReadStartWidthLevel,
		ReadEndWidthLevel:   r.ReadEndWidthLevel,
	}
}
