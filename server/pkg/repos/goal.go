package repos

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
)

type GoalRepository struct {
	db *gorm.DB
}

func NewGoalRepository() *GoalRepository {
	return &GoalRepository{
		db: db,
	}
}

func (r GoalRepository) Create(ctx context.Context, goal *models.Goal) error {
	res := r.db.Create(goal)
	return res.Error
}

func (r GoalRepository) GetByUserID(ctx context.Context, usrID uint) ([]models.Goal, error) {
	var gs []models.Goal

	res := r.db.Find(&gs, "user_id = ?", usrID)
	return gs, res.Error
}
