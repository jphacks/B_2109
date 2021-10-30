package repos

import (
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

func (r UserRepository) GetByID(id uint) (*models.User, error) {
	user := models.User{}
	res := r.db.First(&user, "id = ?", id)
	return &user, res.Error
}
