package models

import (
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

//todo fix
func ConstructUserBook(user User, book Book, bookWidth int64, status ReadStatus) *UserBook {
	return &UserBook{
		UserID:     user.ID,
		BookID:     book.ID,
		WidthLevel: bookWidth,
		ReadStatus: status,
		//Categories: nil,
	}
}
