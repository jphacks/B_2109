package api

import (
	"context"
	"testing"
	"time"

	"github.com/sirupsen/logrus"

	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

const (
	dbUser = "root"
	dbPass = "password"
	dbAddr = "127.0.0.1"
	dbName = "bookowl"

	testUser1ID        = 1
	testUser1Name      = "User1"
	testUser2ID        = 2
	testUser2Name      = "User2"
	testBookmarkID     = 1
	testBookmarkStatus = models.BOOKMARK_STATUS_GREEN
)

var (
	db = &gorm.DB{}
)

func TestApi(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Api Suite")
}

var _ = BeforeSuite(func() {
	err := initDB()
	Expect(err).To(BeNil())
	err = initData()
	Expect(err).To(BeNil())
})

func initDB() (err error) {
	dsn := repos.ConstructDSN(dbUser, dbPass, dbAddr, dbName)
	log.WithField("dsn", dsn).Infof("DSN is constructed")

	cnt := 0
	for {
		if err = repos.InitDB(mysql.Open(dsn), repos.DefaultDBConfig); err != nil && cnt < 10 {
			log.WithFields(logrus.Fields{"Fail Count": cnt}).Warn(err)
			log.Info("sleep 5s")
			time.Sleep(5 * time.Second)
			cnt++
			continue
		} else if err != nil {
			return err
		}
		break
	}

	cnt = 0
	for {
		if db, err = gorm.Open(mysql.Open(dsn), repos.DefaultDBConfig); err != nil && cnt < 10 {
			log.WithFields(logrus.Fields{"Fail Count": cnt}).Warn(err)
			log.Info("sleep 5s")
			time.Sleep(5 * time.Second)
			cnt++
			continue
		} else if err != nil {
			return err
		}
		break
	}
	return nil
}

func initData() error {
	if err := initUsers(); err != nil {
		return err
	}
	if err := initBookmarks(); err != nil {
		return err
	}
	return nil
}

func initUsers() error {
	u1 := models.User{
		Name: testUser1Name,
	}
	u2 := models.User{
		Name: testUser2Name,
	}
	ur := repos.NewUserRepository()

	if _, err := ur.Create(context.Background(), &u1); err != nil {
		return err
	}
	if _, err := ur.Create(context.Background(), &u2); err != nil {
		return err
	}
	return nil
}

func initBookmarks() error {
	bm1 := models.Bookmark{
		Name:   "Bookmark1",
		Status: testBookmarkStatus,
	}
	bmr := repos.NewBookmarkRepository()

	if _, err := bmr.Create(context.Background(), &bm1); err != nil {
		return err
	}
	return nil
}

func getUserBook() (*models.UserBook, error) {
	var ub *models.UserBook

	res := db.First(&ub)
	return ub, res.Error
}
