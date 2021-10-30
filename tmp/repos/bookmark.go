package repos

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
)

type BookmarkRepository struct {
	db *gorm.DB
}

func NewBookmarkRepository() *BookmarkRepository {
	return &BookmarkRepository{
		db: db,
	}
}

func (r BookmarkRepository) GetByID(ctx context.Context, id uint) (*models.Bookmark, error) {
	bm := models.Bookmark{}
	if res := r.db.First(&bm, "id	 = ?", id); res.Error != nil {
		return nil, res.Error
	}
	return &bm, nil
}
