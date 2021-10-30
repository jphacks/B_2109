package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Name      string
	UserBooks []UserBook
	//Goal     Goal
}
