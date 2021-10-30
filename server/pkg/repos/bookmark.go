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

func (r BookmarkRepository) Create(ctx context.Context, bookmark *models.Bookmark) (*models.Bookmark, error) {
	res := r.db.Create(bookmark)
	return bookmark, res.Error
}

func (r BookmarkRepository) UpdateUserBookID(ctx context.Context, bookmark *models.Bookmark, book uint) error {
	res := db.Model(bookmark).Update("user_book_id", book)
	return res.Error
}
