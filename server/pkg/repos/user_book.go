package repos

import (
	"context"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
)

type UserBookRpository struct {
	db *gorm.DB
}

func NewUserBookRepository() *UserBookRpository {
	return &UserBookRpository{
		db: db,
	}
}

func (r UserBookRpository) GetByID(ctx context.Context, id uint, bmk, re bool) (*models.UserBook, error) {
	var res *gorm.DB

	ub := models.UserBook{}
	if bmk && re {
		res = r.db.Preload("Bookmark").Preload("ReadEvents").First(&ub, "id	= ?", id)
	} else if bmk {
		res = r.db.Preload("Bookmark").First(&ub, "id	= ?", id)
	} else if re {
		res = r.db.Preload("ReadEvents").First(&ub, "id	= ?", id)
	} else {
		res = r.db.First(&ub, "id	= ?", id)
	}
	return &ub, res.Error
}

func (r UserBookRpository) GetByBookID(ctx context.Context, id uint) (*models.UserBook, error) {
	ub := models.UserBook{}
	if res := r.db.First(&ub, "book_id = ?", id); res.Error != nil {
		return nil, res.Error
	}
	return &ub, nil
}

func (r UserBookRpository) GetByUserID(ctx context.Context, id uint, bmk, re bool) ([]models.UserBook, error) {
	var ubs []models.UserBook
	var res *gorm.DB

	if bmk && re {
		res = r.db.Preload("Bookmark").Preload("ReadEvents").Find(&ubs, "user_id = ?", id)
	} else if bmk {
		res = r.db.Preload("Bookmark").Find(&ubs, "user_id = ?", id)
	} else if re {
		res = r.db.Preload("ReadEvents").Find(&ubs, "user_id = ?", id)
	} else {
		res = r.db.Find(&ubs, "user_id = ?", id)
	}
	return ubs, res.Error
}

func (r UserBookRpository) Create(ctx context.Context, ub *models.UserBook) error {
	res := r.db.Create(ub)
	return res.Error
}

func (r UserBookRpository) UpdateReadStatus(ctx context.Context, ub *models.UserBook, s models.ReadStatus) (*models.UserBook, error) {
	res := r.db.Model(ub).Update(models.READSTATUS_COLUMN, s)
	return ub, res.Error
}

func (r UserBookRpository) UpdateWidthLevel(ctx context.Context, ub *models.UserBook, width uint64) error {
	return db.Model(ub).Update("width_level", width).Error
}
