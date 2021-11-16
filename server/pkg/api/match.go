package api

import (
	"context"
	"fmt"
	"sort"
	"time"

	"github.com/sirupsen/logrus"

	"github.com/jphacks/B_2109/server/pkg/models"

	"github.com/jphacks/B_2109/server/pkg/repos"

	"google.golang.org/protobuf/types/known/timestamppb"

	"github.com/jphacks/B_2109/server/api"
)

type MatchServer struct {
	api.UnimplementedMatchServer
}

func NewMatchServer() *MatchServer {
	return &MatchServer{}
}

func (s MatchServer) RegisterOpponents(ctx context.Context, r *api.RegisterOpponentsRequest) (*api.RegisterOpponentsResponse, error) {
	err := registerOpponents(ctx, uint(r.GetUserId()), uintSlice(r.GetOpponentIds()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "RegisterOpponents",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}
	return &api.RegisterOpponentsResponse{Time: timestamppb.Now()}, nil
}

func (s MatchServer) GetOpponents(ctx context.Context, r *api.GetOpponentsRequest) (*api.GetOpponentsResponse, error) {
	var ois []*api.OpponentsInfo

	opts, err := getOpponents(ctx, uint(r.GetUserId()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "GetOpponents",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}

	for _, opt := range opts {
		pages, err := getReadPagesWithDuration(ctx, opt.ID, time.Unix(0, 0), time.Now())
		if err != nil {
			return nil, err
		}
		oi := constructOpponentsInfo(opt, uint64(pages))
		ois = append(ois, oi)
	}

	return &api.GetOpponentsResponse{Opponents: ois, Time: timestamppb.Now()}, nil
}

func (s MatchServer) GetRanking(ctx context.Context, r *api.GetRankingRequest) (*api.GetRankingResponse, error) {
	rs, err := getRanking(ctx, uint(r.GetUserId()))
	if err != nil {
		log.WithFields(logrus.Fields{
			"Service": "GetRanking",
			"Request": fmt.Sprintf("%#v", r),
		}).Error(err)
		return nil, err
	}
	return &api.GetRankingResponse{RankingInfos: rs, Time: timestamppb.Now()}, nil
}

func uintSlice(us []uint64) []uint {
	var res []uint

	for _, u := range us {
		res = append(res, uint(u))
	}
	return res
}

func registerOpponents(ctx context.Context, usrID uint, optIDs []uint) error {
	ur := repos.NewUserRepository()
	if err := ur.ClearOpponents(ctx, usrID, optIDs); err != nil {
		return err
	}
	if err := ur.AppendOpponents(ctx, usrID, optIDs); err != nil {
		return err
	}
	return nil
}

func getOpponents(ctx context.Context, usrID uint) ([]*models.User, error) {
	ur := repos.NewUserRepository()
	return ur.GetOpponents(ctx, usrID)
}

func getRanking(ctx context.Context, usrID uint) ([]*api.RankingInfo, error) {
	var ris []*api.RankingInfo

	ur := repos.NewUserRepository()
	opts, err := ur.GetOpponents(ctx, usrID)
	if err != nil {
		return nil, err
	}

	user, err := ur.GetByID(usrID)
	if err != nil {
		return nil, err
	}
	us := append(opts, user)

	pagesUserMap := make(map[int64]*models.User, len(opts)+1)
	for _, u := range us {
		pages, err := getReadPagesWithDuration(ctx, u.ID, time.Unix(0, 0), time.Now())
		if err != nil {
			return nil, err
		}
		pagesUserMap[pages] = u
	}
	rankUserMap := sortByPages(pagesUserMap)
	for r, u := range rankUserMap {
		ri := constructRankingInfo(u, uint64(r))
		ris = append(ris, ri)
	}
	return ris, nil
}

func sortByPages(m map[int64]*models.User) map[int]*models.User {
	pages := make([]int, 0, len(m))
	for k := range m {
		pages = append(pages, int(k))
	}
	sort.Sort(sort.Reverse(sort.IntSlice(pages)))

	rankUserMap := make(map[int]*models.User)
	rank := 1
	for _, p := range pages {
		rankUserMap[rank] = m[int64(p)]
	}
	return rankUserMap
}

func constructOpponentsInfo(o *models.User, pages uint64) *api.OpponentsInfo {
	return &api.OpponentsInfo{
		Id:        uint64(o.ID),
		Name:      o.Name,
		ReadPages: pages,
	}
}

func constructRankingInfo(o *models.User, rank uint64) *api.RankingInfo {
	return &api.RankingInfo{
		Id:      uint64(o.ID),
		Name:    o.Name,
		Ranking: rank,
	}
}
