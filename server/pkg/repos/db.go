package repos

import (
	"fmt"

	"github.com/jphacks/B_2109/server/pkg/models"

	"gorm.io/gorm"
)

var (
	db              = &gorm.DB{}
	DefaultDBConfig = &gorm.Config{
		DisableForeignKeyConstraintWhenMigrating: true,
	}
)

func InitDB(dl gorm.Dialector, cfg *gorm.Config) error {
	var err error

	if db, err = gorm.Open(dl, cfg); err != nil {
		return err
	}

	return db.AutoMigrate(
		&models.Book{},
		&models.Author{},
		&models.Bookmark{},
		//&models.Category{},
		&models.Goal{},
		&models.ReadEvent{},
		&models.User{},
		&models.UserBook{},
	)
}

func ConstructDSN(user string, pass string, addr string, db string) string {
	return fmt.Sprintf("%s:%s@tcp(%s)/%s?parseTime=true", user, pass, addr, db)
}
