package option

import (
	"github.com/jphacks/B_2109/server/pkg/defaults"
	"github.com/spf13/viper"
)

const (
	// ServerAddr is a option for IP address of bookowl server
	ServerAddr = "addr"

	// ServerTls is a option to enable TLS
	ServerTls = "tls"

	// CertFile is a cert-file path option
	CertFile = "cert"

	// KeyFile is a key-file path option
	KeyFile = "key"

	// DBUser is a option for database user
	DBUser = "db-user"

	// DBPass is a option for database password
	//todo given db-pass from env var
	DBPass = "db-pass"

	// DBAddr is a option for database address
	DBAddr = "db-addr"

	// DBName is a option for name of database
	DBName = "db-name"

	HTTPServerAddr = "http-addr"
)

type DaemonConfig struct {
	ServerAddr     string
	ServerTls      bool
	CertFile       string
	KeyFile        string
	DBUser         string
	DBPass         string
	DBAddr         string
	DBName         string
	HTTPServerAddr string
}

var (
	Config = &DaemonConfig{
		ServerAddr:     defaults.ServerAddr,
		ServerTls:      defaults.ServerTls,
		CertFile:       defaults.CertFile,
		KeyFile:        defaults.KeyFile,
		DBUser:         defaults.DBUser,
		DBPass:         defaults.DBPass,
		DBAddr:         defaults.DBAddr,
		DBName:         defaults.DBName,
		HTTPServerAddr: defaults.HTTPServer,
	}
)

func (c *DaemonConfig) Populate() {
	c.ServerAddr = viper.GetString(ServerAddr)
	c.ServerTls = viper.GetBool(ServerTls)
	c.CertFile = viper.GetString(CertFile)
	c.KeyFile = viper.GetString(KeyFile)
	c.DBUser = viper.GetString(DBUser)
	c.DBPass = viper.GetString(DBPass)
	c.DBAddr = viper.GetString(DBAddr)
	c.DBName = viper.GetString(DBName)
	c.HTTPServerAddr = viper.GetString(HTTPServerAddr)
}
