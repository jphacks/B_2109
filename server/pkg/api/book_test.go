package api

import (
	"context"
	"math"
	"time"

	"github.com/jphacks/B_2109/server/api"
	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"gorm.io/gorm"
)

const (
	testUserBook1WidthLevel = 567

	testBook1Name  = "Book1"
	testBook1Pages = 512
	testBook1Price = 1000

	// ref: https://www.oreilly.co.jp/books/9784873119656/
	testISBN = "9784873119656"
)

var _ = Describe("Book", func() {

	Context("Book API", func() {
		BeforeEach(func() {
			err := initBooks()
			Expect(err).To(BeNil())
		})

		AfterEach(func() {
			db.Session(&gorm.Session{AllowGlobalUpdate: true}).Unscoped().Delete(&models.ReadEvent{})
			db.Session(&gorm.Session{AllowGlobalUpdate: true}).Unscoped().Delete(&models.Author{})
			db.Session(&gorm.Session{AllowGlobalUpdate: true}).Unscoped().Delete(&models.UserBook{})
			db.Session(&gorm.Session{AllowGlobalUpdate: true}).Unscoped().Delete(&models.Book{})

		})

		It("tests RegisterBook", func() {
			By("calling registerBook() and nil check for return")
			ub, err := registerBook(context.Background(), testUser1ID, testISBN)
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("checking BookInfo struct")
			bi := constructBookInfo(ub)
			want := api.BookInfo{
				BookId:        uint64(ub.ID),
				Isbn:          testISBN,
				Name:          "Googleのソフトウェアエンジニアリング",
				Pages:         608,
				Price:         4400,
				Authors:       []string{"Titus Winters", "Tom Manshreck", "Hyrum Wright", "竹辺靖昭", "久富木隆一"},
				ReadStatus:    translateModelReadStatus(models.READ_STATUS_UNREAD),
				Categories:    []string{""},
				UserId:        1,
				BookmarkId:    0,
				BookThumbnail: "https://cover.openbd.jp/9784873119656.jpg",
			}
			Expect(bi).To(Equal(&want))
		})

		It("tests UpdateBookmarkID", func() {
			ub, err := getUserBook()
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("calling updateUserBookBookmarkID() and nil check for return")
			newWidth := uint64(100)
			ub, err = updateUserBookBookmarkID(context.Background(), newWidth, ub.ID, testBookmarkID)
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("checking UserBook's BookmarkID and it's ReadingStatus")
			Expect(ub.WidthLevel).To(Equal(int64(newWidth)))
			Expect(ub.ReadStatus).To(Equal(models.READ_STATUS_READING))
		})

		It("tests UpdateReadStatus", func() {
			ub, err := getUserBook()
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			status := models.READ_STATUS_SUSPENDED

			By("calling updateUserBookReadStatus() and nil check for return")
			ub, err = updateUserBookReadStatus(context.Background(), uint64(ub.ID), status)
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("checking UserBook's ReadingStatus")
			Expect(ub.ReadStatus).To(Equal(status))
		})

		It("tests GetBooks", func() {
			By("calling getUserBooks() and nil check for return")
			ubs, err := getUserBooks(context.Background(), testUser1ID)
			Expect(err).To(BeNil())
			Expect(ubs).ToNot(BeNil())

			By("checking fetched UserBooks")
			want := []models.UserBook{
				{
					UserID: testUser1ID,
					//BookID:     testBook1ID,
					WidthLevel: testUserBook1WidthLevel,
					ReadStatus: models.READ_STATUS_READING,
				},
			}
			Expect(len(ubs)).To(Equal(len(want)))
			for i, ub := range ubs {
				Expect(ub.UserID).To(Equal(want[i].UserID))
				//Expect(ub.BookID).To(Equal(want[i].BookID))
				Expect(ub.WidthLevel).To(Equal(want[i].WidthLevel))
				Expect(ub.ReadStatus).To(Equal(want[i].ReadStatus))
			}
		})

		It("tests GetReadRatio", func() {
			By("calling getReadRatio() and nil check for return")
			p, err := getReadRatio(context.Background(), testUser1ID)
			Expect(err).To(BeNil())

			By("checking result")
			want := float64(200) / float64(testUserBook1WidthLevel)
			roundP := math.Round(p * 100)
			rountWant := math.Round(want * 100)
			Expect(roundP).To(Equal(rountWant))
		})

		It("tests GetReadPages", func() {
			By("calling getReadPagesWithDuration() and nil check for return")
			p, err := getReadPagesWithDuration(context.Background(), testUser1ID, time.Unix(0, 0), time.Now())
			Expect(err).To(BeNil())

			By("checking result")
			want := float64(200) / float64(testUserBook1WidthLevel) * testBook1Pages
			Expect(p).To(Equal(int64(want)))
		})

		It("tests GetReadSeconds", func() {
			By("calling getReadSecondsWithDuration() and nil check for return")
			sec, err := getReadSecondsWithDuration(context.Background(), testUser1ID, time.Unix(0, 0), time.Now())
			Expect(err).To(BeNil())

			By("checking result")
			want := int64(1820)
			Expect(sec).To(Equal(want))
		})

		It("tests GetReadSecondsWithDuration", func() {
			By("calling getReadPagesWithDuration() and nil check for return")
			p, err := getReadPagesWithDuration(context.Background(), testUser1ID,
				time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
				time.Date(2021, 11, 14, 10, 10, 10, 0, time.Local))
			Expect(err).To(BeNil())

			By("checking result")
			want := float64(100) / float64(testUserBook1WidthLevel) * testBook1Pages
			Expect(p).To(Equal(int64(want)))
		})

		It("tests GetReadPagesByBookID", func() {
			ub, err := getUserBook()
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("calling getReadPagesByBookID() and nil check for return")
			p, err := getReadPagesByBookID(context.Background(), testUser1ID, ub.ID)
			Expect(err).To(BeNil())

			By("checking result")
			want := float64(200) / float64(testUserBook1WidthLevel) * testBook1Pages
			Expect(p).To(Equal(int64(want)))
		})

		It("tests GetBookmarkStatus", func() {
			By("calling getBookmarkStatus() and nil check for return")
			st, err := getBookmarkStatus(context.Background(), testBookmarkID)
			Expect(err).To(BeNil())

			By("checking result")
			want := testBookmarkStatus
			Expect(st).To(Equal(want))

		})
	})
})

func initBooks() error {
	book1 := models.Book{
		ISBN:          "1",
		Name:          testBook1Name,
		Pages:         testBook1Pages,
		Price:         testBook1Price,
		ThumbnailPath: "",
	}
	br := repos.NewBookRepository()
	if err := br.Create(context.Background(), &book1); err != nil {
		return err
	}

	ub1 := models.UserBook{
		UserID:     testUser1ID,
		BookID:     book1.ID,
		WidthLevel: testUserBook1WidthLevel,
		ReadStatus: models.READ_STATUS_READING,
	}
	ubr := repos.NewUserBookRepository()
	if err := ubr.Create(context.Background(), &ub1); err != nil {
		return err
	}

	re1 := models.ReadEvent{
		UserBookID:          ub1.ID,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 10, 10, 10, 0, time.Local),
		ReadStartWidthLevel: 0,
		ReadEndWidthLevel:   100,
	}
	re2 := models.ReadEvent{
		UserBookID:          ub1.ID,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 50, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 11, 10, 10, 0, time.Local),
		ReadStartWidthLevel: 100,
		ReadEndWidthLevel:   200,
	}
	rer := repos.NewReadEventRpository()
	if err := rer.Create(context.Background(), &re1); err != nil {
		return err
	}
	if err := rer.Create(context.Background(), &re2); err != nil {
		return err
	}
	return nil
}
