package api

import (
	"context"
	"errors"

	"google.golang.org/protobuf/types/known/timestamppb"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/api"
	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/openbd"
	"github.com/jphacks/B_2109/server/pkg/repos"
)

type BookServer struct {
	api.UnimplementedBookServer
}

func NewBookServer() *BookServer {
	s := BookServer{}
	return &s
}

func (s BookServer) RegisterBook(ctx context.Context, r *api.RegisterBookRequest) (*api.RegisterBookResponse, error) {
	ub, err := s.registerBook(ctx, uint(r.GetUserId()), r.GetBookInfo().GetIsbn(), r.GetBookInfo().GetWidthLevel())
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.RegisterBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) GetBooksByUserID(ctx context.Context, r *api.GetBooksByUserIDRequest) (*api.GetBooksResponse, error) {
	var bs []*api.BookInfo

	ubs, err := s.getUserBooksByUserID(ctx, r.GetUserId())
	if err != nil {
		return nil, err
	}
	for _, ub := range ubs {
		bs = append(bs, constructBookInfo(ub))
	}
	return &api.GetBooksResponse{BooksInfo: bs, Time: timestamppb.Now()}, err
}

func (s BookServer) GetBooksByBookmarkID(ctx context.Context, r *api.GetBooksByBookmarkIDRequest) (*api.GetBooksResponse, error) {
	var bs []*api.BookInfo

	ubs, err := s.getUserBooksByBookmarkID(ctx, r.GetBookmarkId())
	if err != nil {
		return nil, err
	}
	for _, ub := range ubs {
		bs = append(bs, constructBookInfo(ub))
	}
	return &api.GetBooksResponse{BooksInfo: bs, Time: timestamppb.Now()}, err
}

func (s BookServer) UpdateBookmarkID(ctx context.Context, r *api.UpdateBookmarkIDRequest) (*api.UpdateBookResponse, error) {
	ub, err := s.updateUserBookBookmarkID(ctx, r.GetBookId(), r.GetBookmarkId())
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.UpdateBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) UpdateReadStatus(ctx context.Context, r *api.UpdateReadStatusRequest) (*api.UpdateBookResponse, error) {
	ub, err := s.updateUserBookReadStatus(ctx, r.GetBookId(), translateAPIReadStatus(r.GetReadStatus()))
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.UpdateBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) registerBook(ctx context.Context, userID uint, isbn string, bookWidth int64) (*models.UserBook, error) {
	ur := repos.NewUserRepository()
	u, err := ur.GetByID(userID)
	if err != nil {
		return nil, err
	}

	br := repos.NewBookRepository()
	b, err := br.GetByISBN(ctx, isbn)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		if b, err = createBookByISBN(ctx, br, isbn); err != nil {
			return nil, err
		}
	} else if err != nil {
		return nil, err
	}

	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByBookID(ctx, b.ID)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		ub = models.ConstructUserBook(u, b, bookWidth, models.READ_STATUS_UNREAD)
		if err = ubr.Create(ctx, ub); err != nil {
			return 0, err
		}
	} else if err != nil {
		return nil, err
	}

	return ub, nil
}

func (s BookServer) getUserBooksByUserID(ctx context.Context, id uint64) ([]*models.UserBook, error) {
	repo := repos.NewUserBookRepository()
	return repo.GetByUserID(ctx, uint(id))
}

func (s BookServer) getUserBooksByBookmarkID(ctx context.Context, id uint64) ([]*models.UserBook, error) {
	repo := repos.NewUserBookRepository()
	return repo.GetByBookmarkID(ctx, uint(id))
}

func (s BookServer) updateUserBookBookmarkID(ctx context.Context, book uint64, bookmark uint64) (*models.UserBook, error) {
	r := repos.NewUserBookRepository()
	ub, err := r.GetByID(ctx, uint(book))
	if err != nil {
		return nil, err
	}
	return r.UpdateBookmarkID(ctx, ub, uint(bookmark))
}

func (s BookServer) updateUserBookReadStatus(ctx context.Context, book uint64, status models.ReadStatus) (*models.UserBook, error) {
	r := repos.NewUserBookRepository()
	ub, err := r.GetByID(ctx, uint(book))
	if err != nil {
		return nil, err
	}
	return r.UpdateReadStatus(ctx, ub, status)
}

func constructBookInfo(b *models.UserBook) *api.BookInfo {
	return &api.BookInfo{
		BookId:        uint64(b.ID),
		Isbn:          b.Book.ISBN,
		Name:          b.Book.Name,
		Pages:         b.Book.Pages,
		Price:         b.Book.Price,
		Authors:       b.Book.Authors.GetAuthorNameSlice(),
		ReadStatus:    translateModelReadStatus(b.ReadStatus),
		Categories:    b.Categories.GetCategoryNameSlice(),
		UserId:        uint64(b.User.ID),
		BookmarkId:    uint64(b.Bookmark.ID),
		BookThumbnail: b.Book.ThumbnailPath,
	}
}

func translateModelReadStatus(s models.ReadStatus) api.ReadStatus {
	switch s {
	case models.READ_STATUS_UNREAD:
		return api.ReadStatus_READ_UNREAD
	case models.READ_STATUS_READING:
		return api.ReadStatus_READ_READING
	case models.READ_STATUS_SUSPENDED:
		return api.ReadStatus_READ_SUSPENDED
	case models.READ_STATUS_COMPLETE:
		return api.ReadStatus_READ_COMPLETE
	}
	return api.ReadStatus_READ_UNSPECIFIED
}

func translateAPIReadStatus(s api.ReadStatus) models.ReadStatus {
	switch s {
	case api.ReadStatus_READ_UNREAD:
		return models.READ_STATUS_UNREAD
	case api.ReadStatus_READ_READING:
		return models.READ_STATUS_READING
	case api.ReadStatus_READ_SUSPENDED:
		return models.READ_STATUS_SUSPENDED
	case api.ReadStatus_READ_COMPLETE:
		return models.READ_STATUS_COMPLETE
	}
	return models.READ_STATUS_UNREAD
}

func createBookByISBN(ctx context.Context, br *repos.BookRpository, isbn string) (*models.Book, error) {
	b, err := openbd.FetchBook(ctx, isbn)
	if err != nil {
		return nil, err
	}

	err = br.Create(ctx, b)
	return b, err
}
