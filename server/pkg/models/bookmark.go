package models

import (
	"gorm.io/gorm"
)

const (
	BOOKMARK_STATUS_UNSPECIFIED BookmarkStatus = 0
	BOOKMARK_STATUS_GREEN       BookmarkStatus = 1
	BOOKMARK_STATUS_RED         BookmarkStatus = 2
)

type BookmarkStatus int

type Bookmark struct {
	gorm.Model
	Name       string
	UserBookID uint
	Status     BookmarkStatus
}
