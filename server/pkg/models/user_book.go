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

	BOOKMARK_COLUMN   = "bookmark"
	READSTATUS_COLUMN = "read_status"
)

type ReadStatus string

type UserBook struct {
	gorm.Model
	User       User
	Book       Book
	WidthLevel int64
	ReadStatus ReadStatus `gorm:"type:enum('unread', 'reading', 'complete);default:'unread'"`
	Categories Categories `gorm:"many2many:userbook_categories;"`
	Bookmark   Bookmark
}

func ConstructUserBook(user User, book Book, bookWidth int64, status ReadStatus) *UserBook {
	return &UserBook{
		User:       user,
		Book:       book,
		WidthLevel: bookWidth,
		ReadStatus: status,
		Categories: nil,
	}
}
