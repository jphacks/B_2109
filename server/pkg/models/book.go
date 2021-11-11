package models

import (
	"gorm.io/gorm"
)

type Book struct {
	gorm.Model
	ISBN          string
	Name          string
	Pages         int64
	Price         int64
	Authors       Authors
	UserBooks     []UserBook
	ThumbnailPath string
}

func ConstructBook(isbn, name string, pages int64, price int64, authors Authors, thumbnail string) *Book {
	return &Book{
		ISBN:          isbn,
		Name:          name,
		Pages:         pages,
		Price:         price,
		Authors:       authors,
		ThumbnailPath: thumbnail,
	}

}
