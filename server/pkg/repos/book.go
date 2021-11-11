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

func (r BookRpository) GetByID(ctx context.Context, id uint, author, ub bool) (*models.Book, error) {
	var res *gorm.DB

	b := models.Book{}
	if author && ub {
		res = db.Preload("Authors").Preload("UserBooks").First(&b, "id = ?", id)
	} else if author {
		res = db.Preload("Authors").First(&b, "id = ?", id)
	} else if ub {
		res = db.Preload("UserBooks").First(&b, "id = ?", id)
	} else {
		res = db.First(&b, "id = ?", id)
	}
	return &b, res.Error
}

func (r BookRpository) GetByISBN(ctx context.Context, isbn string, authors, userBooks bool) (*models.Book, error) {
	book := models.Book{}

	if authors && userBooks {
		if res := r.db.Preload("Authors").Preload("UserBooks").First(&book, "isbn = ?", isbn); res.Error != nil {
			return nil, res.Error
		}
	} else if authors {
		if res := r.db.Preload("Authors").First(&book, "isbn = ?", isbn); res.Error != nil {
			return nil, res.Error
		}
	} else if userBooks {
		if res := r.db.Preload("UserBooks").First(&book, "isbn = ?", isbn); res.Error != nil {
			return nil, res.Error
		}
	} else {
		if res := r.db.First(&book, "isbn = ?", isbn); res.Error != nil {
			return nil, res.Error
		}
	}

	return &book, nil
}

func (r BookRpository) Create(ctx context.Context, book *models.Book) error {
	return r.db.Create(book).Error
}
