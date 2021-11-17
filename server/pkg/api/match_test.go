package api

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/api"
	"github.com/jphacks/B_2109/server/pkg/models"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Match", func() {
	Context("Match API", func() {
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

		It("tests RegisterOpponents, GetOpponents, GetRanking", func() {
			By("calling registerOpponents() and nil check for return")
			err := registerOpponents(context.Background(), testUser1ID, []uint{testUser2ID})
			Expect(err).To(BeNil())

			By("calling getOpponents() and nil check for return")
			opts, err := getOpponents(context.Background(), testUser1ID)
			Expect(err).To(BeNil())

			By("checking result")
			want := []models.User{{
				Name: testUser2Name,
			}}
			Expect(len(opts)).To(Equal(len(want)))
			for i, opt := range opts {
				Expect(opt.Name).To(Equal(want[i].Name))
			}

			By("calling getRanking() and nil check for return")
			rs, err := getRanking(context.Background(), testUser1ID)
			Expect(err).To(BeNil())

			By("checking result")
			wantRanking := []*api.RankingInfo{
				{
					Id:      testUser1ID,
					Name:    testUser1Name,
					Ranking: 1,
				},
				{
					Id:      testUser2ID,
					Name:    testUser2Name,
					Ranking: 2,
				},
			}
			Expect(len(rs)).To(Equal(len(wantRanking)))
			for i, r := range rs {
				Expect(r.Id).To(Equal(wantRanking[i].Id))
				Expect(r.Name).To(Equal(wantRanking[i].Name))
				Expect(r.Ranking).To(Equal(wantRanking[i].Ranking))
			}
		})
	})
})
