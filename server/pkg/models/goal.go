package models

import (
	"time"

	"gorm.io/gorm"
)

const (
	GOAL_STATUS_PENDING  GoalStatus = "pending"
	GOAL_STATUS_DOING    GoalStatus = "doing"
	GOAL_STATUS_COMPLETE GoalStatus = "complete"
	GOAL_STATUS_FAILED   GoalStatus = "failed"
)

type GoalStatus string

type Goal struct {
	gorm.Model
	StartDate  time.Time
	EndDate    time.Time
	NumPages   int64
	GoalStatus GoalStatus `gorm:"type:enum('pending', 'doing', 'complete', 'failed');default:'pending'"`
	UserID     uint
}
