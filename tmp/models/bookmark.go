package models

import (
	"gorm.io/gorm"
)

type Bookmark struct {
	gorm.Model
	Name string `gorm:"index:name_idx"`
}
