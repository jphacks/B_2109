package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Name      string
	UserBooks []UserBook
	Opponents []User `gorm:"many2many:user_opponents"`
	//Goal     Goal
}
