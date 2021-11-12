package models

import "gorm.io/gorm"

type Match struct {
	gorm.Model
	UserID         uint
	OpponentUserID uint
}
