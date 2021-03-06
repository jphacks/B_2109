package models

import (
	"gorm.io/gorm"
)

type Book struct {
	gorm.Model
	ISBN          string `gorm:"uniqueIndex:isbn_idx"`
	Name          string
	Pages         int64
	Price         int64
	Authors       Authors
	ThumbnailPath string
}

func ConstructBook(isbn, name string, pages int64, price int64, authors []*Author, thumbnail string) *Book {
	return &Book{
		ISBN:          isbn,
		Name:          name,
		Pages:         pages,
		Price:         price,
		Authors:       authors,
		ThumbnailPath: thumbnail,
	}

}
