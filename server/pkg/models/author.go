package models

import (
	"log"

	"gorm.io/gorm"
)

type Author struct {
	gorm.Model
	Name   string
	BookID uint
}

func GetAuthorNameSlice(as []Author) []string {
	var names []string

	log.Println(as)
	for _, a := range as {
		names = append(names, a.Name)
	}
	log.Println(names)
	return names
}

func ConstructAuthor(name string) Author {
	return Author{Name: name}
}
