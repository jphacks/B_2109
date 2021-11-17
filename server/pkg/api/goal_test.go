package api

import (
	"context"
	"time"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

const (
	testGoal1NumPages = 100
	testGoal1Status   = models.GOAL_STATUS_PENDING
	testGoal2NumPages = 200
)

var (
	testGoal1StartDate = time.Date(2021, 11, 15, 00, 00, 0, 0, time.Local)
	testGoal1EndDate   = time.Date(2021, 11, 22, 00, 00, 0, 0, time.Local)
	testGoal2StartDate = time.Date(2021, 11, 22, 00, 00, 0, 0, time.Local)
	testGoal2EndDate   = time.Date(2021, 11, 29, 00, 00, 0, 0, time.Local)
)

var _ = Describe("Goal", func() {
	Context("Goal API", func() {
		BeforeEach(func() {
			err := initGoals()
			Expect(err).To(BeNil())
		})

		AfterEach(func() {
			db.Session(&gorm.Session{AllowGlobalUpdate: true}).Unscoped().Delete(&models.Goal{})
		})

		It("tests CreateGoal", func() {
			By("calling createGoal() and nil check for return")
			g, err := createGoal(context.Background(), time.Date(2021, 11, 24, 00, 00, 0, 0, time.Local),
				testGoal2NumPages, testUser1ID)
			Expect(err).To(BeNil())

			By("checking result")
			want := models.Goal{
				StartDate:  testGoal2StartDate,
				EndDate:    testGoal2EndDate,
				NumPages:   testGoal2NumPages,
				GoalStatus: models.GOAL_STATUS_DOING,
				UserID:     testUser1ID,
			}
			Expect(g.StartDate).To(Equal(want.StartDate))
			Expect(g.EndDate).To(Equal(want.EndDate))
			Expect(g.NumPages).To(Equal(want.NumPages))
			Expect(g.GoalStatus).To(Equal(want.GoalStatus))
			Expect(g.UserID).To(Equal(want.UserID))
		})

		It("tests GetGoals", func() {
			By("calling getGoals() and nil check for return")
			gs, err := getGoals(context.Background(), testUser1ID)
			Expect(err).To(BeNil())

			By("checking result")
			want := []models.Goal{{
				StartDate:  testGoal1StartDate,
				EndDate:    testGoal1EndDate,
				NumPages:   testGoal1NumPages,
				GoalStatus: testGoal1Status,
				UserID:     testUser1ID,
			}}
			Expect(len(gs)).To(Equal(len(want)))
			for i, g := range gs {
				Expect(g.StartDate.Local()).To(Equal(want[i].StartDate))
				Expect(g.EndDate.Local()).To(Equal(want[i].EndDate))
				Expect(g.NumPages).To(Equal(want[i].NumPages))
				Expect(g.GoalStatus).To(Equal(want[i].GoalStatus))
				Expect(g.UserID).To(Equal(want[i].UserID))
			}
		})
	})
})

func initGoals() error {
	goal1 := models.Goal{
		StartDate:  testGoal1StartDate,
		EndDate:    testGoal1EndDate,
		NumPages:   testGoal1NumPages,
		GoalStatus: testGoal1Status,
		UserID:     testUser1ID,
	}
	gr := repos.NewGoalRepository()
	if err := gr.Create(context.Background(), &goal1); err != nil {
		return err
	}
	return nil
}
