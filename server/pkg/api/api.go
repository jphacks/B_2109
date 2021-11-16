package api

import (
	"github.com/jphacks/B_2109/server/pkg/logging"
	"github.com/jphacks/B_2109/server/pkg/logging/logfields"
)

const (
	Api = "api"
)

var (
	log = logging.DefaultLogger.WithField(logfields.Package, Api)
)
