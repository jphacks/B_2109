package api

import (
	"context"
	"time"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

const (
	testReadEventStartWidth = 200
	testReadEventEndWidth   = 300
)

var (
	testReadEventStartTime = time.Date(2021, 11, 25, 10, 0, 0, 0, time.Local)
	testReadEventEndTime   = time.Date(2021, 11, 25, 10, 10, 0, 0, time.Local)
)

var _ = Describe("ReadEvent", func() {
	Context("ReadEvent API", func() {
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

		It("tests CreateReadEvent", func() {
			ub, err := getUserBook()
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("calling createReadEvent() and nil check for return")
			re, err := createReadEvent(context.Background(), testBookmarkID, testReadEventStartTime, testReadEventEndTime,
				testReadEventStartWidth, testReadEventEndWidth)
			Expect(err).To(BeNil())

			By("checking result")
			want := models.ReadEvent{
				//UserBookID:          ub.ID,
				ReadStartTime:       testReadEventStartTime,
				ReadEndTime:         testReadEventEndTime,
				ReadStartWidthLevel: testReadEventStartWidth,
				ReadEndWidthLevel:   testReadEventEndWidth,
			}
			//Expect(re.UserBookID).To(Equal(want.UserBookID))
			Expect(re.ReadStartTime.Local()).To(Equal(want.ReadStartTime))
			Expect(re.ReadEndTime.Local()).To(Equal(want.ReadEndTime))
			Expect(re.ReadStartWidthLevel).To(Equal(want.ReadStartWidthLevel))
			Expect(re.ReadEndWidthLevel).To(Equal(want.ReadEndWidthLevel))
		})

		It("tests GetReadEventsByBookID", func() {
			ub, err := getUserBook()
			Expect(err).To(BeNil())
			Expect(ub).ToNot(BeNil())

			By("calling getReadEventsByUserBookID() and nil check for return")
			res, err := getReadEventsByUserBookID(context.Background(), ub.ID)
			Expect(err).To(BeNil())

			want := []models.ReadEvent{
				{
					UserBookID:          ub.ID,
					ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
					ReadEndTime:         time.Date(2021, 11, 14, 10, 10, 10, 0, time.Local),
					ReadStartWidthLevel: 0,
					ReadEndWidthLevel:   100,
				},
				{
					UserBookID:          ub.ID,
					ReadStartTime:       time.Date(2021, 11, 14, 10, 50, 0, 0, time.Local),
					ReadEndTime:         time.Date(2021, 11, 14, 11, 10, 10, 0, time.Local),
					ReadStartWidthLevel: 100,
					ReadEndWidthLevel:   200,
				},
			}
			Expect(len(res)).To(Equal(len(want)))
			for i, re := range res {
				Expect(re.UserBookID).To(Equal(want[i].UserBookID))
				Expect(re.ReadStartTime.Local()).To(Equal(want[i].ReadStartTime))
				Expect(re.ReadEndTime.Local()).To(Equal(want[i].ReadEndTime))
				Expect(re.ReadStartWidthLevel).To(Equal(want[i].ReadStartWidthLevel))
				Expect(re.ReadEndWidthLevel).To(Equal(want[i].ReadEndWidthLevel))
			}
		})
	})
})
