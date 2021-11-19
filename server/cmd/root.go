/*
Copyright © 2021 JPHACKS

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package cmd

import (
	"context"
	"fmt"
	"net"
	"os"
	"time"

	"github.com/sirupsen/logrus"

	"github.com/jphacks/B_2109/server/api"
	pkgapi "github.com/jphacks/B_2109/server/pkg/api"
	"github.com/jphacks/B_2109/server/pkg/defaults"
	"github.com/jphacks/B_2109/server/pkg/logging"
	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/option"
	"github.com/jphacks/B_2109/server/pkg/repos"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"gorm.io/driver/mysql"

	"golang.org/x/sync/errgroup"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

func init() {
	// flags
	flags := rootCmd.Flags()

	flags.String(option.ServerAddr, defaults.ServerAddr, fmt.Sprintf("Server IP address (default is %s)", defaults.ServerAddr))
	flags.Bool(option.ServerTls, defaults.ServerTls, fmt.Sprintf("TLS flag (default is %v)", defaults.ServerTls))
	flags.String(option.CertFile, defaults.CertFile, fmt.Sprintf("Cert file path (default is %s)", defaults.CertFile))
	flags.String(option.KeyFile, defaults.KeyFile, fmt.Sprintf("Key file path (default is %s)", defaults.KeyFile))
	flags.String(option.DBUser, defaults.DBUser, fmt.Sprintf("DB User (default is %s)", defaults.DBUser))
	flags.String(option.DBPass, defaults.DBPass, fmt.Sprintf("DB password (default is %s)", defaults.DBPass))
	flags.String(option.DBAddr, defaults.DBAddr, fmt.Sprintf("DB Address (default is %s)", defaults.DBAddr))
	flags.String(option.DBName, defaults.DBName, fmt.Sprintf("DB Name (default is %s)", defaults.DBName))
	flags.String(option.HTTPServerAddr, defaults.HTTPServer, fmt.Sprintf("HTTP addr (default is %s)", defaults.HTTPServer))

	viper.BindPFlags(flags)
}

const (
	maxDBInitFail = 10
)

var (
	log = logging.DefaultLogger
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "bookowl",
	Short: "bookowl",
	Run: func(cmd *cobra.Command, args []string) {
		// initialize
		log.Info("Initialize Start")
		initEnv()
		if err := initDB(); err != nil {
			log.Error(err)
			return
		}

		log.Info("Inject init Data")
		if err := initData(); err != nil {
			log.Error(err)
			return
		}

		log.Info("Server Start")
		if err := runDaemon(); err != nil {
			log.Error(err)
			return
		}
		return
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func initEnv() {
	option.Config.Populate()
}

func initDB() error {
	dsn := repos.ConstructDSN(option.Config.DBUser, option.Config.DBPass, option.Config.DBAddr, option.Config.DBName)
	log.WithField("dsn", dsn).Infof("DSN is constructed")
	cnt := 0
	for {
		if err := repos.InitDB(mysql.Open(dsn), repos.DefaultDBConfig); err != nil && cnt < maxDBInitFail {
			log.WithFields(logrus.Fields{"Fail Count": cnt}).Warn(err)
			log.Info("sleep 5s")
			time.Sleep(5 * time.Second)
			cnt++
		} else {
			return err
		}
	}
}

func initData() error {
	ur := repos.NewUserRepository()
	_, err := ur.Create(context.Background(), &models.User{
		Name: "五十嵐 双葉",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "武田 晴海",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "桜井 桃子",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "風間 蒼太",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "黒部 夏美",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "桜井 優人",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "月城 モナ",
	})
	if err != nil {
		return err
	}
	_, err = ur.Create(context.Background(), &models.User{
		Name: "ナスラ",
	})
	if err != nil {
		return err
	}

	br := repos.NewBookRepository()
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "1",
		Name:          "dummy1",
		Pages:         100,
		Price:         200,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "2",
		Name:          "dummy2",
		Pages:         200,
		Price:         200,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "3",
		Name:          "dummy3",
		Pages:         300,
		Price:         300,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "4",
		Name:          "dummy4",
		Pages:         400,
		Price:         400,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "5",
		Name:          "dummy5",
		Pages:         500,
		Price:         500,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "6",
		Name:          "dummy6",
		Pages:         600,
		Price:         600,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "7",
		Name:          "dummy7",
		Pages:         700,
		Price:         700,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}
	err = br.Create(context.Background(), &models.Book{
		ISBN:          "8",
		Name:          "dummy8",
		Pages:         800,
		Price:         800,
		ThumbnailPath: "",
	})
	if err != nil {
		return err
	}

	ubr := repos.NewUserBookRepository()
	err = ubr.Create(context.Background(), &models.UserBook{
		UserID:     2,
		BookID:     2,
		WidthLevel: 100,
		ReadStatus: models.READ_STATUS_COMPLETE,
	})
	if err != nil {
		return err
	}
	err = ubr.Create(context.Background(), &models.UserBook{
		UserID:     3,
		BookID:     3,
		WidthLevel: 100,
		ReadStatus: models.READ_STATUS_COMPLETE,
	})
	if err != nil {
		return err
	}
	err = ubr.Create(context.Background(), &models.UserBook{
		UserID:     4,
		BookID:     6,
		WidthLevel: 100,
		ReadStatus: models.READ_STATUS_COMPLETE,
	})
	if err != nil {
		return err
	}
	err = ubr.Create(context.Background(), &models.UserBook{
		UserID:     5,
		BookID:     8,
		WidthLevel: 100,
		ReadStatus: models.READ_STATUS_COMPLETE,
	})
	if err != nil {
		return err
	}

	bmr := repos.NewBookmarkRepository()
	_, err = bmr.Create(context.Background(), &models.Bookmark{
		Name:       "しおり1",
		UserBookID: 1,
	})
	if err != nil {
		return err
	}
	_, err = bmr.Create(context.Background(), &models.Bookmark{
		Name:       "しおり2",
		UserBookID: 1,
	})
	if err != nil {
		return err
	}
	_, err = bmr.Create(context.Background(), &models.Bookmark{
		Name:       "しおり3",
		UserBookID: 1,
	})
	if err != nil {
		return err
	}
	_, err = bmr.Create(context.Background(), &models.Bookmark{
		Name:       "しおり4",
		UserBookID: 1,
	})
	if err != nil {
		return err
	}

	rer := repos.NewReadEventRpository()
	err = rer.Create(context.Background(), &models.ReadEvent{
		UserBookID:          1,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 10, 30, 0, 0, time.Local),
		ReadStartWidthLevel: 0,
		ReadEndWidthLevel:   100,
	})
	if err != nil {
		return err
	}
	err = rer.Create(context.Background(), &models.ReadEvent{
		UserBookID:          2,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 10, 30, 0, 0, time.Local),
		ReadStartWidthLevel: 0,
		ReadEndWidthLevel:   100,
	})
	if err != nil {
		return err
	}
	err = rer.Create(context.Background(), &models.ReadEvent{
		UserBookID:          3,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 10, 30, 0, 0, time.Local),
		ReadStartWidthLevel: 0,
		ReadEndWidthLevel:   100,
	})
	if err != nil {
		return err
	}
	err = rer.Create(context.Background(), &models.ReadEvent{
		UserBookID:          4,
		ReadStartTime:       time.Date(2021, 11, 14, 10, 0, 0, 0, time.Local),
		ReadEndTime:         time.Date(2021, 11, 14, 10, 30, 0, 0, time.Local),
		ReadStartWidthLevel: 0,
		ReadEndWidthLevel:   100,
	})
	if err != nil {
		return err
	}

	return nil
}

func runDaemon() error {
	eg := errgroup.Group{}
	eg.Go(func() error {
		return runServer()
	})
	//todo implement
	//eg.Go(func() error {
	//	return runDailyGoalUpdate()
	//})

	return eg.Wait()
}

func runServer() error {
	s, err := initServer()
	if err != nil {
		return err
	}

	api.RegisterBookServer(s, pkgapi.NewBookServer())
	api.RegisterReadEventServer(s, pkgapi.NewReadEventServer())
	api.RegisterGoalServer(s, pkgapi.NewGoalServer())
	api.RegisterMatchServer(s, pkgapi.NewMatchServer())

	lis, err := net.Listen("tcp", option.Config.ServerAddr)
	if err != nil {
		return err
	}
	return s.Serve(lis)
}

func initServer() (*grpc.Server, error) {
	var opts []grpc.ServerOption

	if option.Config.ServerTls {
		if creds, err := credentials.NewServerTLSFromFile(option.Config.CertFile, option.Config.KeyFile); err != nil {
			return nil, err
		} else {
			opts = []grpc.ServerOption{grpc.Creds(creds)}
		}
	}
	return grpc.NewServer(opts...), nil
}

//func runDailyGoalUpdate() error {
//	//todo implement
//	return nil
//}
