package repos

import (
	"context"

	"github.com/jphacks/B_2109/server/pkg/models"
	"gorm.io/gorm"
)

type ReadEventRepository struct {
	db *gorm.DB
}

func NewReadEventRpository() *ReadEventRepository {
	return &ReadEventRepository{
		db: db,
	}
}

func (r ReadEventRepository) Get(ctx context.Context) ([]models.ReadEvent, error) {
	var events []models.ReadEvent
	res := db.Find(&events)
	return events, res.Error
}

func (r ReadEventRepository) Create(ctx context.Context, re *models.ReadEvent) error {
	return r.db.Create(re).Error
}

func (r ReadEventRepository) GetByUserBookID(ctx context.Context, id uint) ([]models.ReadEvent, error) {
	var rs []models.ReadEvent
	if res := r.db.Find(&rs, models.ReadEvent{UserBookID: id}); res.Error != nil {
		return nil, res.Error
	}
	return rs, nil
}
