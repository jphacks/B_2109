package repos

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
)

type BookRpository struct {
	db *gorm.DB
}

func NewBookRepository() *BookRpository {
	return &BookRpository{
		db: db,
	}
}

func (r BookRpository) GetByISBN(ctx context.Context, isbn string) (*models.Book, error) {
	book := models.Book{}
	if res := r.db.First(&book, "isbn = ?", isbn); res.Error != nil {
		return nil, res.Error
	}
	return &book, nil
}

func (r BookRpository) Create(ctx context.Context, book *models.Book) error {
	return r.db.Create(book).Error
}
