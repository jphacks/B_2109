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
	"log"
	"net"
	"os"
	"os/signal"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/api"

	"github.com/spf13/viper"

	pkgapi "github.com/jphacks/B_2109/server/pkg/api"
	"github.com/jphacks/B_2109/server/pkg/defaults"
	"github.com/jphacks/B_2109/server/pkg/option"
	"github.com/jphacks/B_2109/server/pkg/repos"

	"golang.org/x/sync/errgroup"

	"github.com/spf13/cobra"
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

	viper.BindPFlags(flags)
}

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "bookowl",
	Short: "bookowl",
	Run: func(cmd *cobra.Command, args []string) {
		// initialize
		initEnv()
		if err := initDB(); err != nil {
			//	todo logrus
			log.Fatalln(err)
		}

		log.Println("Server Start")
		if err := runDaemon(); err != nil {
			//	todo logrus
			log.Fatalln(err)

		}
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
	return repos.InitDB(mysql.Open(dsn), &gorm.Config{})
}

func runDaemon() error {
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt)
	defer stop()

	eg, ctx := errgroup.WithContext(ctx)
	eg.Go(func() error {
		return runServer(ctx)
	})
	eg.Go(func() error {
		return runDailyGoalUpdate(ctx)
	})

	return eg.Wait()
}

func runServer(ctx context.Context) error {
	s, err := initServer()
	if err != nil {
		return err
	}

	// note ここ美しくない
	api.RegisterBookServer(s, pkgapi.NewBookServer())
	api.RegisterReadEventServer(s, pkgapi.NewReadEventServer())
	//api.RegisterGoalServer(s, pkgapi.NewGoalServer())

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

func runDailyGoalUpdate(ctx context.Context) error {
	//todo implement
	return nil
}
