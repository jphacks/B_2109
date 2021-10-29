package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Name string `gorm:"index:name_idx"`
}
