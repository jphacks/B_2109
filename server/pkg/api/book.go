package api

import (
	"context"
	"errors"
	"time"

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
	ub, err := registerBook(ctx, uint(r.GetUserId()), r.GetIsbn())
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.RegisterBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) UpdateBookmarkID(ctx context.Context, r *api.UpdateBookmarkIDRequest) (*api.UpdateBookResponse, error) {
	ub, err := updateUserBookBookmarkID(ctx, r.GetBookWidth(), uint(r.GetBookId()), uint(r.GetBookmarkId()))
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.UpdateBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) UpdateReadStatus(ctx context.Context, r *api.UpdateReadStatusRequest) (*api.UpdateBookResponse, error) {
	ub, err := updateUserBookReadStatus(ctx, r.GetBookId(), translateAPIReadStatus(r.GetReadStatus()))
	if err != nil {
		return nil, err
	}
	b := constructBookInfo(ub)
	return &api.UpdateBookResponse{BookInfo: b, Time: timestamppb.Now()}, err
}

func (s BookServer) GetBooks(ctx context.Context, r *api.GetBooksRequest) (*api.GetBooksResponse, error) {
	var bs []*api.BookInfo

	ubs, err := getUserBooks(ctx, uint(r.GetUserId()))
	if err != nil {
		return nil, err
	}
	for _, ub := range ubs {
		bs = append(bs, constructBookInfo(&ub))
	}
	return &api.GetBooksResponse{BooksInfo: bs, Time: timestamppb.Now()}, err
}

func (s BookServer) GetReadRatio(ctx context.Context, r *api.GetReadRatioRequest) (*api.GetReadRatioResponse, error) {
	p, err := getReadRatio(ctx, uint(r.GetUserId()))
	if err != nil {
		return nil, err
	}
	return &api.GetReadRatioResponse{ReadPercentage: p, Time: timestamppb.Now()}, nil
}

func (s BookServer) GetReadPages(ctx context.Context, r *api.GetReadPagesRequest) (*api.GetReadPagesResponse, error) {
	p, err := getReadPagesWithDuration(ctx, uint(r.GetUserId()), time.Unix(0, 0), time.Now())
	if err != nil {
		return nil, err
	}
	return &api.GetReadPagesResponse{ReadPages: uint64(p), Time: timestamppb.Now()}, nil
}

func (s BookServer) GetReadSeconds(ctx context.Context, r *api.GetReadSecondsRequest) (*api.GetReadSecondsResponse, error) {
	sec, err := getReadSecondsWithDuration(ctx, uint(r.GetUserId()), time.Unix(0, 0), time.Now())
	if err != nil {
		return nil, err
	}
	return &api.GetReadSecondsResponse{ReadSeconds: uint64(sec), Time: timestamppb.Now()}, nil
}

func (s BookServer) GetReadPagesWithDuration(ctx context.Context, r *api.GetReadPagesWithDurationRequest) (*api.GetReadPagesResponse, error) {
	p, err := getReadPagesWithDuration(ctx, uint(r.GetUserId()), r.GetStartTime().AsTime(), r.GetEndTime().AsTime())
	if err != nil {
		return nil, err
	}
	return &api.GetReadPagesResponse{ReadPages: uint64(p), Time: timestamppb.Now()}, nil
}

func (s BookServer) GetReadSecondsWithDuration(ctx context.Context, r *api.GetReadSecondsWithDurationRequest) (*api.GetReadSecondsResponse, error) {
	sec, err := getReadSecondsWithDuration(ctx, uint(r.GetUserId()), r.GetStartTime().AsTime(), r.GetEndTime().AsTime())
	if err != nil {
		return nil, err
	}
	return &api.GetReadSecondsResponse{ReadSeconds: uint64(sec), Time: timestamppb.Now()}, nil
}

func (s BookServer) GetReadPagesByBookID(ctx context.Context, r *api.GetReadPagesByBookIDRequest) (*api.GetReadPagesResponse, error) {
	p, err := getReadPagesByBookID(ctx, uint(r.GetUserId()), uint(r.GetBookId()))
	if err != nil {
		return nil, err
	}
	return &api.GetReadPagesResponse{ReadPages: uint64(p), Time: timestamppb.Now()}, nil
}

func (s BookServer) GetBookmarkStatus(ctx context.Context, r *api.GetBookmarkStatusRequest) (*api.GetBookmarkStatusResponse, error) {
	st, err := getBookmarkStatus(ctx, uint(r.GetBookmarkId()))
	if err != nil {
		return nil, err
	}
	return &api.GetBookmarkStatusResponse{BookmarkStatus: st, Time: timestamppb.Now()}, nil

}

func registerBook(ctx context.Context, userID uint, isbn string) (*models.UserBook, error) {
	ur := repos.NewUserRepository()
	u, err := ur.GetByID(userID)
	if err != nil {
		return nil, err
	}

	b, err := createBookIfNotExists(ctx, isbn)
	if err != nil {
		return nil, err
	}

	return createUserBookIfNotExists(ctx, u.ID, b.ID)
}

func createBookIfNotExists(ctx context.Context, isbn string) (*models.Book, error) {
	br := repos.NewBookRepository()
	b, err := br.GetByISBN(ctx, isbn, false, false)
	if err == nil {
		return b, nil
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, err
	}

	return createBook(ctx, br, isbn)
}

func createBook(ctx context.Context, r *repos.BookRpository, isbn string) (*models.Book, error) {
	b, err := openbd.FetchBook(ctx, isbn)
	if err != nil {
		return nil, err
	}

	err = r.Create(ctx, b)
	return b, err
}

func createUserBookIfNotExists(ctx context.Context, userID, bookID uint) (*models.UserBook, error) {
	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByBookID(ctx, bookID)
	if err == nil {
		return ub, err
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, err
	}

	return createUserBook(ctx, ubr, userID, bookID)
}

func createUserBook(ctx context.Context, r *repos.UserBookRpository, userID, bookID uint) (*models.UserBook, error) {
	ub := models.ConstructUserBook(userID, bookID, 0, models.READ_STATUS_UNREAD)
	err := r.Create(ctx, ub)
	return ub, err
}

func updateUserBookBookmarkID(ctx context.Context, width uint64, ubID, bmkID uint) (*models.UserBook, error) {
	bmr := repos.NewBookmarkRepository()
	bm, err := bmr.GetByID(ctx, bmkID)
	if err != nil {
		return nil, err
	}
	err = bmr.UpdateUserBookID(ctx, bm, ubID)

	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByID(ctx, ubID, false, false)
	if err != nil {
		return nil, err
	}

	err = ubr.UpdateWidthLevel(ctx, ub, width)
	if err != nil {
		return nil, err
	}

	return changeReadingUserBook(ctx, ubr, ubID, bmkID)
}

func changeReadingUserBook(ctx context.Context, ubr *repos.UserBookRpository, ubID, bmkID uint) (*models.UserBook, error) {
	reading := &models.UserBook{}
	ubs, err := ubr.GetByBookmarkID(ctx, bmkID)
	for _, ub := range ubs {
		if ub.ID == ubID {
			reading, err = ubr.UpdateReadStatus(ctx, &ub, models.READ_STATUS_READING)
			if err != nil {
				return nil, err
			}
			continue
		}

		if ub.ReadStatus == models.READ_STATUS_READING {
			_, err = ubr.UpdateReadStatus(ctx, &ub, models.READ_STATUS_SUSPENDED)
			if err != nil {
				return nil, err
			}
		}
	}
	return reading, nil
}

func updateUserBookReadStatus(ctx context.Context, book uint64, status models.ReadStatus) (*models.UserBook, error) {
	r := repos.NewUserBookRepository()
	ub, err := r.GetByID(ctx, uint(book), false, false)
	if err != nil {
		return nil, err
	}
	return r.UpdateReadStatus(ctx, ub, status)
}

func getUserBooks(ctx context.Context, usrID uint) ([]models.UserBook, error) {
	repo := repos.NewUserBookRepository()
	return repo.GetByUserID(ctx, usrID, false, false)
}

func getReadRatio(ctx context.Context, usrID uint) (float64, error) {
	ubr := repos.NewUserBookRepository()
	ubs, err := ubr.GetByUserID(ctx, usrID, false, true)
	if err != nil {
		return 0, err
	}
	totalPages, totalReadPages, err := getTotalPagesAndReadPagesWithDuration(ubs, time.Unix(0, 0), time.Now())
	return float64(totalReadPages) / float64(totalPages), err
}

func getReadPagesWithDuration(ctx context.Context, usrID uint, start, end time.Time) (int64, error) {
	ubr := repos.NewUserBookRepository()
	ubs, err := ubr.GetByUserID(ctx, usrID, false, true)
	if err != nil {
		return 0, err
	}
	_, totalReadPages, err := getTotalPagesAndReadPagesWithDuration(ubs, start, end)
	return totalReadPages, nil
}

func getReadSecondsWithDuration(ctx context.Context, usrID uint, start, end time.Time) (int64, error) {
	ubr := repos.NewUserBookRepository()
	ubs, err := ubr.GetByUserID(ctx, usrID, false, true)
	if err != nil {
		return 0, err
	}

	totalSec := int64(0)
	for _, ub := range ubs {
		sec := ub.GetReadSecondsWithDuration(start, end)
		totalSec += sec
	}
	return totalSec, nil
}

func getReadPagesByBookID(ctx context.Context, usrID, bookID uint) (int64, error) {
	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByID(ctx, bookID, false, true)
	if err != nil {
		return 0, err
	}

	r := ub.GetReadRatioWithDuration(time.Unix(0, 0), time.Now())
	t, err := getBookTotalPages(ub)
	if err != nil {
		return 0, err
	}
	return int64(r * float64(t)), nil
}

func getTotalPagesAndReadPagesWithDuration(ubs []models.UserBook, start, end time.Time) (totalPages int64, totalReadPages int64, err error) {
	for _, ub := range ubs {
		pages, err := getBookTotalPages(&ub)
		if err != nil {
			return 0, 0, err
		}
		totalPages += pages

		p := ub.GetReadRatioWithDuration(start, end)
		totalReadPages += int64(p * float64(pages))
	}
	return totalPages, totalReadPages, nil
}

func getBookTotalPages(ub *models.UserBook) (int64, error) {
	br := repos.NewBookRepository()
	b, err := br.GetByID(context.Background(), ub.BookID, false, false)
	return b.Pages, err
}

func getBookmarkStatus(ctx context.Context, bmID uint) (api.BookmarkStatus, error) {
	bmr := repos.NewBookmarkRepository()
	bm, err := bmr.GetByID(ctx, bmID)
	if err != nil {
		return api.BookmarkStatus_BOOKMARK_STATUS_UNSPECIFIED, err
	}

	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByID(ctx, bm.UserBookID, false, true)
	if err != nil {
		return api.BookmarkStatus_BOOKMARK_STATUS_UNSPECIFIED, err
	}

	t := ub.GetLastReadEndTime()
	if time.Now().AddDate(0, 0, -7).Before(t) {
		return api.BookmarkStatus_BOOKMARK_STATUS_RED, nil
	}
	return api.BookmarkStatus_BOOKMARK_STATUS_GREEN, nil
}

func constructBookInfo(ub *models.UserBook) *api.BookInfo {
	br := repos.NewBookRepository()
	b, _ := br.GetByID(context.Background(), ub.BookID, true, false)
	return &api.BookInfo{
		BookId:        uint64(ub.ID),
		Isbn:          b.ISBN,
		Name:          b.Name,
		Pages:         b.Pages,
		Price:         b.Price,
		Authors:       b.Authors.GetAuthorNameSlice(),
		ReadStatus:    translateModelReadStatus(ub.ReadStatus),
		Categories:    []string{""},
		UserId:        uint64(ub.UserID),
		BookmarkId:    uint64(ub.Bookmark.ID),
		BookThumbnail: b.ThumbnailPath,
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
