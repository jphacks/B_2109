package api

import (
	"context"
	"errors"
	"log"
	"math"
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
	log.Printf("[DEBUG] width %v", r.GetBookInfo().GetWidthLevel())
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
		bs = append(bs, constructBookInfo(&ub))
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
		bs = append(bs, constructBookInfo(&ub))
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

func (s BookServer) GetProgressByUserID(ctx context.Context, r *api.GetProgressByUserIDRequest) (*api.GetProgressByUserIDResponse, error) {
	p, err := s.getProgressByUserID(ctx, uint(r.GetUserId()))
	if err != nil {
		return nil, err
	}
	return &api.GetProgressByUserIDResponse{
		Progress: float32(p),
		Time:     timestamppb.Now(),
	}, nil
}

func (s BookServer) GetReadAmountPagesByUserIDWithDuration(ctx context.Context, r *api.GetReadAmountPagesByUserIDWithDurationRequest) (*api.GetReadAmountPagesByUserIDWithDurationResponse, error) {
	p, err := s.getReadAmountPagesByUserIDWithDuration(ctx, uint(r.GetUserId()), r.GetStart().AsTime(), r.GetEnd().AsTime())
	if err != nil {
		return nil, err
	}
	return &api.GetReadAmountPagesByUserIDWithDurationResponse{
		Pages: p,
		Time:  timestamppb.Now(),
	}, nil

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
		log.Println("[DEBUG] get by isbn not found")
		if b, err = createBookByISBN(ctx, br, isbn); err != nil {
			log.Printf("[ERROR] %v", err)
			return nil, err
		}
	} else if err != nil {
		return nil, err
	}

	log.Println("[DEBUG] fetch book done")

	ubr := repos.NewUserBookRepository()
	ub, err := ubr.GetByBookID(ctx, b.ID)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		log.Println("[DEBUG] ubr.GetByBookID not found")
		ub = models.ConstructUserBook(*u, *b, bookWidth, models.READ_STATUS_UNREAD)
		if err = ubr.Create(ctx, ub); err != nil {
			log.Printf("[ERROR] %v", err)
			return nil, err
		}
	} else if err != nil {
		log.Printf("[ERROR] %v", err)
		return nil, err
	}

	log.Println("[DEBUG] Register Book success")
	return ub, nil
}

func (s BookServer) getUserBooksByUserID(ctx context.Context, id uint64) ([]models.UserBook, error) {
	repo := repos.NewUserBookRepository()
	return repo.GetByUserID(ctx, uint(id))
}

func (s BookServer) getUserBooksByBookmarkID(ctx context.Context, id uint64) ([]models.UserBook, error) {
	repo := repos.NewUserBookRepository()
	return repo.GetByBookmarkID(ctx, uint(id))
}

func (s BookServer) updateUserBookBookmarkID(ctx context.Context, book uint64, bookmark uint64) (*models.UserBook, error) {

	r := repos.NewBookmarkRepository()
	bmk, err := r.GetByID(ctx, uint(bookmark))
	if err != nil {
		return nil, err
	}
	err = r.UpdateUserBookID(ctx, bmk, uint(book))

	ubr := repos.NewUserBookRepository()

	//ubs, err := ubr.GetByBookmarkID(ctx, uint(bookmark))
	//for _, ub := range ubs {
	//	if ub.ReadStatus == models.READ_STATUS_READING {
	//		_, err = ubr.UpdateReadStatus(ctx, &ub, models.READ_STATUS_SUSPENDED)
	//		if err != nil {
	//			log.Printf("[ERROR] Readstatus %v", err)
	//		}
	//	}
	//}

	ub, err := ubr.GetByID(ctx, bmk.UserBookID)
	if err != nil {
		return nil, err
	}
	ub, err = ubr.UpdateReadStatus(ctx, ub, models.READ_STATUS_READING)
	return ub, err
}

func (s BookServer) updateUserBookReadStatus(ctx context.Context, book uint64, status models.ReadStatus) (*models.UserBook, error) {
	r := repos.NewUserBookRepository()
	ub, err := r.GetByID(ctx, uint(book))
	if err != nil {
		return nil, err
	}
	return r.UpdateReadStatus(ctx, ub, status)
}

func (s BookServer) getProgressByUserID(ctx context.Context, id uint) (float64, error) {
	//r := repos.NewUserBookRepository()
	//ubs, err := r.GetByUserID(ctx, id)
	//if err != nil {
	//	return 0, err
	//}
	//
	//readTotal := 0
	//total := 0
	//for _, ub := range ubs {
	//	maxLevel := 0
	//	for _, e := range ub.ReadEvents {
	//		maxLevel = int(math.Max(float64(maxLevel), float64(e.ReadEndWidthLevel)))
	//	}
	//	readTotal += int(float64(maxLevel) / float64(ub.WidthLevel))
	//
	//	br := repos.NewBookRepository()
	//	book, _ := br.GetByID(context.Background(), ub.ID)
	//	total += int(book.Pages)
	//}
	//
	//return float64(readTotal) / float64(total), nil
	r := repos.NewUserBookRepository()
	ubs, err := r.GetByUserID(context.Background(), id)
	if err != nil {
		return 0, err
	}
	log.Println(ubs)

	total := 0
	readTotal := 0.0
	for _, ub := range ubs {
		readTotalRatio := 0.0
		maxLevel := 0
		ub.ReadEvents = getReadEvents(ub.ID)
		for _, e := range ub.ReadEvents {
			maxLevel = int(math.Max(float64(maxLevel), float64(e.ReadEndWidthLevel)))
		}
		log.Printf("maxLevel %v", maxLevel)
		log.Printf("WidthLevel %v", ub.WidthLevel)
		readTotalRatio += float64(maxLevel) / float64(ub.WidthLevel)

		br := repos.NewBookRepository()
		book, _ := br.GetByID(context.Background(), ub.ID)
		total += int(book.Pages)
		readTotal += readTotalRatio * float64(book.Pages)
	}
	log.Printf("readTotal %v", readTotal)
	log.Printf("total %v", total)

	return readTotal / float64(total), nil
}

func (s BookServer) getReadAmountPagesByUserIDWithDuration(ctx context.Context, id uint, start, end time.Time) (uint64, error) {
	//r := repos.NewUserBookRepository()
	//ubs, err := r.GetByUserID(ctx, id)
	//if err != nil {
	//	return 0, err
	//}
	//
	//readTotal := 0
	//for _, ub := range ubs {
	//	br := repos.NewBookRepository()
	//	book, _ := br.GetByID(context.Background(), ub.ID)
	//	readTotalLevel := 0
	//	for _, e := range ub.ReadEvents {
	//		if judgeInTerm(start, end, e.ReadStartTime, e.ReadEndTime) {
	//			tmp := int(e.ReadEndWidthLevel - e.ReadStartWidthLevel)
	//			if tmp > 0 {
	//				readTotalLevel += tmp
	//			}
	//		}
	//	}
	//	readTotal += readTotalLevel * int(book.Pages)
	//}

	r := repos.NewUserBookRepository()
	ubs, err := r.GetByUserID(context.Background(), id)
	if err != nil {
		return 0, err
	}
	log.Println(ubs)

	readTotal := 0.0
	for _, ub := range ubs {
		readTotalLevel := 0
		maxLevel := 0
		ub.ReadEvents = getReadEvents(ub.ID)
		for _, e := range ub.ReadEvents {
			if !judgeInTerm(start, end, e.ReadStartTime, e.ReadEndTime) {
				continue
			}
			tmp := int(e.ReadEndWidthLevel - e.ReadStartWidthLevel)
			if tmp > 0 {
				readTotalLevel += tmp
			}
		}
		log.Printf("maxLevel %v", maxLevel)
		log.Printf("WidthLevel %v", ub.WidthLevel)

		br := repos.NewBookRepository()
		book, _ := br.GetByID(context.Background(), ub.ID)
		readTotal += (float64(readTotalLevel) / float64(ub.WidthLevel)) * float64(book.Pages)
	}
	log.Printf("readTotal %v", readTotal)

	return uint64(readTotal), nil
}

func getReadEvents(userBookID uint) []models.ReadEvent {
	rer := repos.NewReadEventRpository()
	res, err := rer.GetByUserBookID(context.Background(), userBookID)
	log.Println(err)
	return res
}

func constructBookInfo(b *models.UserBook) *api.BookInfo {
	br := repos.NewBookRepository()
	book, _ := br.GetByID(context.Background(), b.BookID)
	ar := repos.NewAuthorRepository()
	authors, err := ar.GetByBookID(context.Background(), book.ID)
	if err != nil {
		log.Printf("[ERROR] %v", err)
	}
	return &api.BookInfo{
		BookId:        uint64(b.ID),
		Isbn:          book.ISBN,
		Name:          book.Name,
		Pages:         book.Pages,
		Price:         book.Price,
		Authors:       models.GetAuthorNameSlice(authors),
		ReadStatus:    translateModelReadStatus(b.ReadStatus),
		Categories:    []string{""},
		UserId:        uint64(b.UserID),
		BookmarkId:    uint64(b.Bookmark.ID),
		BookThumbnail: book.ThumbnailPath,
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

	log.Println(b)
	err = br.Create(ctx, b)
	return b, err
}

func judgeInTerm(srcStart, srcEnd, tgtStart, tgtEnd time.Time) bool {
	if srcStart.Before(tgtStart) || srcEnd.After(tgtStart) {
		return false
	}
	if srcStart.Before(tgtEnd) || srcEnd.After(tgtEnd) {
		return false
	}
	return true
}
