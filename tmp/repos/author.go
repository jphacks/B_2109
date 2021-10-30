package repos

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
)

type AuthorRepository struct {
	db *gorm.DB
}

func NewAuthorRepository() *AuthorRepository {
	return &AuthorRepository{
		db: db,
	}
}

func (r AuthorRepository) GetByName(ctx context.Context, name string) (*models.Author, error) {
	a := models.Author{}
	if res := r.db.First(&a, "name = ?", name); res.Error != nil {
		return nil, res.Error
	}
	return &a, nil
}

func (r AuthorRepository) Create(ctx context.Context, author *models.Author) error {
	return r.db.Create(author).Error
}
