package repos

import (
	"fmt"
	"time"

	"github.com/jphacks/B_2109/server/pkg/logging"
	"github.com/jphacks/B_2109/server/pkg/models"

	"gorm.io/gorm"
)

var (
	log = logging.DefaultLogger
	db  = &gorm.DB{}
)

func InitDB(dl gorm.Dialector, cfg *gorm.Config) error {
	var err error

	for {
		if db, err = gorm.Open(dl, cfg); err != nil {
			log.Warn(err)
			log.Info("sleep 5s")
			time.Sleep(5 * time.Second)
		} else {
			break
		}
	}

	return db.AutoMigrate(
		&models.Book{},
		&models.Author{},
		&models.Bookmark{},
		//&models.Category{},
		//&models.Goal{},
		&models.ReadEvent{},
		&models.User{},
		&models.UserBook{},
	)
}

func ConstructDSN(user string, pass string, addr string, db string) string {
	return fmt.Sprintf("%s:%s@tcp(%s)/%s?parseTime=true", user, pass, addr, db)
}
