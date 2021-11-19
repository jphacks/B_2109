package api

import (
	"context"
	"fmt"
	"time"

	"github.com/sirupsen/logrus"

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
	log.WithFields(logrus.Fields{
		"Service": "CreateReadEvent",
		"Request": fmt.Sprintf("%#v", r),
	}).Info("request comes.")

	re, err := createReadEvent(ctx, uint(r.GetBookmarkId()), r.GetReadEventInfo().GetReadStartTime().AsTime(), r.GetReadEventInfo().GetReadEndTime().AsTime(),
		r.GetReadEventInfo().ReadStartWidthRevel, r.GetReadEventInfo().GetReadEndWidthLevel())
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "CreateReadEvent",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}

	return &api.CreateReadEventResponse{ReadEventId: uint64(re.ID), Time: timestamppb.Now()}, nil
}

func (s ReadEventServer) GetReadEventsByBookID(ctx context.Context, r *api.GetReadEventsByBookIDRequest) (*api.GetReadEventsResponse, error) {
	var ris []*api.ReadEventInfo

	log.WithFields(logrus.Fields{
		"Service": "GetReadEventsByBookID",
		"Request": fmt.Sprintf("%#v", r),
	}).Info("request comes.")

	res, err := getReadEventsByUserBookID(ctx, uint(r.GetBookId()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "GetReadEventsByBookID",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}
	for _, re := range res {
		ris = append(ris, constructReadEventInfo(&re))
	}

	return &api.GetReadEventsResponse{ReadEventsInfo: ris, Time: timestamppb.Now()}, nil
}

func createReadEvent(ctx context.Context, bmID uint, start, end time.Time, startWidth, endWidth int64) (*models.ReadEvent, error) {
	bmr := repos.NewBookmarkRepository()
	bm, err := bmr.GetByID(ctx, bmID)
	if err != nil {
		return nil, err
	}
	re := models.ConstructReadEvent(bm.UserBookID, start, end, startWidth, endWidth)
	rer := repos.NewReadEventRpository()
	err = rer.Create(ctx, re)
	return re, err
}

func getReadEventsByUserBookID(ctx context.Context, id uint) ([]models.ReadEvent, error) {
	rer := repos.NewReadEventRpository()
	return rer.GetByUserBookID(ctx, id)
}

func constructReadEventInfo(r *models.ReadEvent) *api.ReadEventInfo {
	return &api.ReadEventInfo{
		ReadStartTime:       timestamppb.New(r.ReadStartTime),
		ReadEndTime:         timestamppb.New(r.ReadEndTime),
		ReadStartWidthRevel: r.ReadStartWidthLevel,
		ReadEndWidthLevel:   r.ReadEndWidthLevel,
	}
}
