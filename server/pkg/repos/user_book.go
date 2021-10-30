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

func (r UserBookRpository) GetByID(ctx context.Context, id uint) (*models.UserBook, error) {
	ub := models.UserBook{}
	res := r.db.First(&ub, "id	= ?", id)
	return &ub, res.Error
}

func (r UserBookRpository) GetByBookID(ctx context.Context, id uint) (*models.UserBook, error) {
	ub := models.UserBook{}
	if res := r.db.First(&ub, "book_id = ?", id); res.Error != nil {
		return nil, res.Error
	}
	return &ub, nil
}

func (r UserBookRpository) GetByUserID(ctx context.Context, id uint) ([]models.UserBook, error) {
	var ubs []models.UserBook
	if res := r.db.Find(&ubs, "user_id = ?", id); res.Error != nil {
		return nil, res.Error
	}
	return ubs, nil
}

func (r UserBookRpository) GetByBookmarkID(ctx context.Context, id uint) ([]models.UserBook, error) {
	var ubs []models.UserBook
	result := r.db.Find(&ubs, "bookmark_id = ?", id)
	return ubs, result.Error
}

func (r UserBookRpository) Create(ctx context.Context, ub *models.UserBook) error {
	res := r.db.Create(ub)
	return res.Error
}

func (r UserBookRpository) UpdateBookmarkID(ctx context.Context, ub *models.UserBook, id uint) (*models.UserBook, error) {
	res := r.db.Model(ub).Update(models.BOOKMARK_COLUMN, id)
	return ub, res.Error
}

func (r UserBookRpository) UpdateReadStatus(ctx context.Context, ub *models.UserBook, s models.ReadStatus) (*models.UserBook, error) {
	res := r.db.Model(ub).Update(models.READSTATUS_COLUMN, s)
	return ub, res.Error
}

func (r UserBookRpository) UpdateReadStatusWithBookmarkID(ctx context.Context, tgt models.ReadStatus, dst models.ReadStatus, id uint) error {
	return r.db.Model(&models.UserBook{}).Where("read_status = ? AND bookmark = ?", tgt, id).Update("read_status", dst).Error
}
