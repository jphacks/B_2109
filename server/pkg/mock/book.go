package mock

import (
	"context"

	"google.golang.org/protobuf/types/known/timestamppb"

	"github.com/jphacks/B_2109/server/api"
)

type BookServer struct {
	api.UnimplementedBookServer
}

func NewBookServer() *BookServer {
	s := BookServer{}
	return &s
}

func (s BookServer) RegisterBook(ctx context.Context, r *api.RegisterBookRequest) (*api.RegisterBookResponse, error) {
	return &api.RegisterBookResponse{BookInfo: nil, Time: timestamppb.Now()}, nil
}

func (s BookServer) GetBooksByUserID(ctx context.Context, r *api.GetBooksByUserIDRequest) (*api.GetBooksResponse, error) {
	return &api.GetBooksResponse{BooksInfo: nil, Time: timestamppb.Now()}, nil
}

func (s BookServer) GetBooksByBookmarkID(ctx context.Context, r *api.GetBooksByBookmarkIDRequest) (*api.GetBooksResponse, error) {
	return &api.GetBooksResponse{BooksInfo: nil, Time: timestamppb.Now()}, nil
}

func (s BookServer) UpdateBookmarkID(ctx context.Context, r *api.UpdateBookmarkIDRequest) (*api.UpdateBookResponse, error) {
	return &api.UpdateBookResponse{BookInfo: nil, Time: timestamppb.Now()}, nil
}

func (s BookServer) UpdateReadStatus(ctx context.Context, r *api.UpdateReadStatusRequest) (*api.UpdateBookResponse, error) {
	return &api.UpdateBookResponse{BookInfo: nil, Time: timestamppb.Now()}, nil
}
