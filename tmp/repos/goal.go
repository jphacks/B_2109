package repos

import (
	"context"

	"github.com/jphacks/B_2109/server/pkg/models"
	"gorm.io/gorm"
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
	return r.db.Create(goal).Error
}
