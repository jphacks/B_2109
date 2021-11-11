package models

import (
	"math"
	"time"

	"gorm.io/gorm"
)

const (
	READ_STATUS_UNREAD  ReadStatus = "unread"
	READ_STATUS_READING ReadStatus = "reading"
	// READ_STATUS_SUSPENDED is status of not reading now but started reading
	READ_STATUS_SUSPENDED ReadStatus = "suspended"
	READ_STATUS_COMPLETE  ReadStatus = "complete"

	BOOKMARK_COLUMN   = "bookmark_id"
	READSTATUS_COLUMN = "read_status"
)

type ReadStatus string

type UserBook struct {
	gorm.Model
	UserID     uint
	BookID     uint
	WidthLevel int64
	ReadStatus ReadStatus
	//Categories Categories `gorm:"many2many:userbook_categories;"`
	Bookmark   Bookmark
	ReadEvents []ReadEvent
}

func (ub *UserBook) GetReadRatioWithDuration(start, end time.Time) float64 {
	minStartWidth := 1024.0
	maxEndWidth := 0.0
	for _, e := range ub.ReadEvents {
		if start.Before(e.ReadStartTime) || end.After(e.ReadEndTime) {
			continue
		}
		minStartWidth = math.Min(minStartWidth, float64(e.ReadStartWidthLevel))
		maxEndWidth = math.Max(maxEndWidth, float64(e.ReadEndWidthLevel))
	}

	res := (maxEndWidth - minStartWidth) / float64(ub.WidthLevel)
	if res < 0 {
		res = 0
	}
	return res
}

func (ub UserBook) GetReadSecondsWithDuration(start, end time.Time) int64 {
	sec := int64(0)
	for _, e := range ub.ReadEvents {
		if start.Before(e.ReadStartTime) || end.After(e.ReadEndTime) {
			continue
		}
		sec += int64(e.ReadEndTime.Sub(e.ReadStartTime).Seconds())
	}
	return sec
}

func (ub UserBook) GetLastReadEndTime() time.Time {
	t := time.Unix(0, 0)
	for _, e := range ub.ReadEvents {
		if t.After(e.ReadEndTime) {
			t = e.ReadEndTime
		}
	}
	return t
}

func ConstructUserBook(userID, bookID uint, bookWidth int64, status ReadStatus) *UserBook {
	return &UserBook{
		UserID:     userID,
		BookID:     bookID,
		WidthLevel: bookWidth,
		ReadStatus: status,
		//Categories: nil,
	}
}
