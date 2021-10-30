package models

import (
	"time"

	"gorm.io/gorm"
)

type ReadEvent struct {
	gorm.Model
	UserBookID          uint
	ReadStartTime       time.Time
	ReadEndTime         time.Time
	ReadStartWidthLevel int64
	ReadEndWidthLevel   int64
}

//todo fix
func ConstructReadEvent(ub UserBook, start, end time.Time, startWidth, endWidth int64) *ReadEvent {
	return &ReadEvent{
		UserBookID:          ub.ID,
		ReadStartTime:       start,
		ReadEndTime:         end,
		ReadStartWidthLevel: startWidth,
		ReadEndWidthLevel:   endWidth,
	}
}
