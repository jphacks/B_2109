package repos

import (
	"context"

	"github.com/jphacks/B_2109/server/pkg/models"
	"gorm.io/gorm"
)

type UserRepository struct {
	db *gorm.DB
}

func NewUserRepository() *UserRepository {
	return &UserRepository{
		db: db,
	}
}

func (r UserRepository) GetAll() ([]*models.User, error) {
	var us []*models.User

	res := r.db.Find(&us)
	return us, res.Error
}

func (r UserRepository) GetByID(id uint) (*models.User, error) {
	user := models.User{}
	res := r.db.First(&user, "id = ?", id)
	return &user, res.Error
}

func (r UserRepository) Create(ctx context.Context, user *models.User) (*models.User, error) {
	res := r.db.Create(user)
	return user, res.Error
}

func (r UserRepository) ClearOpponents(ctx context.Context, usrID uint, optIDs []uint) error {
	var opts []*models.User

	u, err := r.GetByID(usrID)
	if err != nil {
		return err
	}

	for _, optID := range optIDs {
		opt, err := r.GetByID(optID)
		if err != nil {
			return err
		}
		opts = append(opts, opt)
	}

	if err := db.Model(&u).Association("Opponents").Clear(); err != nil {
		return err
	}
	return nil
}

func (r UserRepository) AppendOpponents(ctx context.Context, usrID uint, optIDs []uint) error {
	var opts []*models.User

	u, err := r.GetByID(usrID)
	if err != nil {
		return err
	}

	for _, optID := range optIDs {
		opt, err := r.GetByID(optID)
		if err != nil {
			return err
		}
		opts = append(opts, opt)
	}

	if err := db.Model(&u).Association("Opponents").Append(opts); err != nil {
		return err
	}
	return nil
}

func (r UserRepository) GetOpponents(ctx context.Context, usrID uint) ([]*models.User, error) {
	var opts []*models.User

	u, err := r.GetByID(usrID)
	if err != nil {
		return nil, err
	}
	if err := db.Model(&u).Association("Opponents").Find(&opts); err != nil {
		return nil, err
	}
	return opts, nil
}
