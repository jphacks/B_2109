package models

import (
	"gorm.io/gorm"
)

type Author struct {
	gorm.Model
	Name string `gorm:"index:name_idx"`
}

type Authors []*Author

func (as Authors) GetAuthorNameSlice() []string {
	var names []string

	for _, a := range as {
		names = append(names, a.Name)
	}
	return names
}

func ConstructAuthor(name string) *Author {
	return &Author{Name: name}
}
