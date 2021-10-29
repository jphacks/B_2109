package api

import "errors"

var (
	ErrNoBookmark        = errors.New("specified Bookmark is not found")
	ErrNoReadingUserBook = errors.New("UserBook in reading with specified Bookmark is not found")
)
