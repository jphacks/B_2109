package models

import (
	"time"

	"gorm.io/gorm"
)

type ReadEvent struct {
	gorm.Model
	UserBook            *UserBook
	ReadStartTime       time.Time
	ReadEndTime         time.Time
	ReadStartWidthLevel int64
	ReadEndWidthLevel   int64
}

func ConstructReadEvent(ub *UserBook, start, end time.Time, startWidth, endWidth int64) *ReadEvent {
	return &ReadEvent{
		UserBook:            ub,
		ReadStartTime:       start,
		ReadEndTime:         end,
		ReadStartWidthLevel: startWidth,
		ReadEndWidthLevel:   endWidth,
	}
}
