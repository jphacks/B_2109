// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.26.0
// 	protoc        v3.17.3
// source: goal.proto

package api

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type GoalStatus int32

const (
	GoalStatus_GOAL_UNKNOWN  GoalStatus = 0
	GoalStatus_GOAL_PENDING  GoalStatus = 1
	GoalStatus_GOAL_DOING    GoalStatus = 2
	GoalStatus_GOAL_COMPLETE GoalStatus = 3
	GoalStatus_GOAL_FAILED   GoalStatus = 4
)

// Enum value maps for GoalStatus.
var (
	GoalStatus_name = map[int32]string{
		0: "GOAL_UNKNOWN",
		1: "GOAL_PENDING",
		2: "GOAL_DOING",
		3: "GOAL_COMPLETE",
		4: "GOAL_FAILED",
	}
	GoalStatus_value = map[string]int32{
		"GOAL_UNKNOWN":  0,
		"GOAL_PENDING":  1,
		"GOAL_DOING":    2,
		"GOAL_COMPLETE": 3,
		"GOAL_FAILED":   4,
	}
)

func (x GoalStatus) Enum() *GoalStatus {
	p := new(GoalStatus)
	*p = x
	return p
}

func (x GoalStatus) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (GoalStatus) Descriptor() protoreflect.EnumDescriptor {
	return file_goal_proto_enumTypes[0].Descriptor()
}

func (GoalStatus) Type() protoreflect.EnumType {
	return &file_goal_proto_enumTypes[0]
}

func (x GoalStatus) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use GoalStatus.Descriptor instead.
func (GoalStatus) EnumDescriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{0}
}

type RegisterGoalRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalInfo *GoalInfo `protobuf:"bytes,1,opt,name=goal_info,json=goalInfo,proto3" json:"goal_info,omitempty"`
}

func (x *RegisterGoalRequest) Reset() {
	*x = RegisterGoalRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *RegisterGoalRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*RegisterGoalRequest) ProtoMessage() {}

func (x *RegisterGoalRequest) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use RegisterGoalRequest.ProtoReflect.Descriptor instead.
func (*RegisterGoalRequest) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{0}
}

func (x *RegisterGoalRequest) GetGoalInfo() *GoalInfo {
	if x != nil {
		return x.GoalInfo
	}
	return nil
}

type RegisterGoalResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalId uint64                 `protobuf:"varint,1,opt,name=goal_id,json=goalId,proto3" json:"goal_id,omitempty"`
	Time   *timestamppb.Timestamp `protobuf:"bytes,2,opt,name=time,proto3" json:"time,omitempty"`
}

func (x *RegisterGoalResponse) Reset() {
	*x = RegisterGoalResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *RegisterGoalResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*RegisterGoalResponse) ProtoMessage() {}

func (x *RegisterGoalResponse) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use RegisterGoalResponse.ProtoReflect.Descriptor instead.
func (*RegisterGoalResponse) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{1}
}

func (x *RegisterGoalResponse) GetGoalId() uint64 {
	if x != nil {
		return x.GoalId
	}
	return 0
}

func (x *RegisterGoalResponse) GetTime() *timestamppb.Timestamp {
	if x != nil {
		return x.Time
	}
	return nil
}

type GetGoalByUserIDRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	UserId uint64 `protobuf:"varint,1,opt,name=user_id,json=userId,proto3" json:"user_id,omitempty"`
}

func (x *GetGoalByUserIDRequest) Reset() {
	*x = GetGoalByUserIDRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *GetGoalByUserIDRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*GetGoalByUserIDRequest) ProtoMessage() {}

func (x *GetGoalByUserIDRequest) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use GetGoalByUserIDRequest.ProtoReflect.Descriptor instead.
func (*GetGoalByUserIDRequest) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{2}
}

func (x *GetGoalByUserIDRequest) GetUserId() uint64 {
	if x != nil {
		return x.UserId
	}
	return 0
}

type GetGoalResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalInfo []*GoalInfo            `protobuf:"bytes,1,rep,name=goal_info,json=goalInfo,proto3" json:"goal_info,omitempty"`
	Time     *timestamppb.Timestamp `protobuf:"bytes,2,opt,name=time,proto3" json:"time,omitempty"`
}

func (x *GetGoalResponse) Reset() {
	*x = GetGoalResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *GetGoalResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*GetGoalResponse) ProtoMessage() {}

func (x *GetGoalResponse) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use GetGoalResponse.ProtoReflect.Descriptor instead.
func (*GetGoalResponse) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{3}
}

func (x *GetGoalResponse) GetGoalInfo() []*GoalInfo {
	if x != nil {
		return x.GoalInfo
	}
	return nil
}

func (x *GetGoalResponse) GetTime() *timestamppb.Timestamp {
	if x != nil {
		return x.Time
	}
	return nil
}

type UpdateGoalStatusRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalId     uint64     `protobuf:"varint,1,opt,name=goal_id,json=goalId,proto3" json:"goal_id,omitempty"`
	GoalStatus GoalStatus `protobuf:"varint,2,opt,name=goal_status,json=goalStatus,proto3,enum=bookowl.GoalStatus" json:"goal_status,omitempty"`
}

func (x *UpdateGoalStatusRequest) Reset() {
	*x = UpdateGoalStatusRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *UpdateGoalStatusRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*UpdateGoalStatusRequest) ProtoMessage() {}

func (x *UpdateGoalStatusRequest) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use UpdateGoalStatusRequest.ProtoReflect.Descriptor instead.
func (*UpdateGoalStatusRequest) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{4}
}

func (x *UpdateGoalStatusRequest) GetGoalId() uint64 {
	if x != nil {
		return x.GoalId
	}
	return 0
}

func (x *UpdateGoalStatusRequest) GetGoalStatus() GoalStatus {
	if x != nil {
		return x.GoalStatus
	}
	return GoalStatus_GOAL_UNKNOWN
}

type UpdateGoalResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalInfo *GoalInfo              `protobuf:"bytes,1,opt,name=goal_info,json=goalInfo,proto3" json:"goal_info,omitempty"`
	Time     *timestamppb.Timestamp `protobuf:"bytes,2,opt,name=time,proto3" json:"time,omitempty"`
}

func (x *UpdateGoalResponse) Reset() {
	*x = UpdateGoalResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[5]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *UpdateGoalResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*UpdateGoalResponse) ProtoMessage() {}

func (x *UpdateGoalResponse) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[5]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use UpdateGoalResponse.ProtoReflect.Descriptor instead.
func (*UpdateGoalResponse) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{5}
}

func (x *UpdateGoalResponse) GetGoalInfo() *GoalInfo {
	if x != nil {
		return x.GoalInfo
	}
	return nil
}

func (x *UpdateGoalResponse) GetTime() *timestamppb.Timestamp {
	if x != nil {
		return x.Time
	}
	return nil
}

type GoalInfo struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	GoalId            uint64                 `protobuf:"varint,1,opt,name=goal_id,json=goalId,proto3" json:"goal_id,omitempty"`
	StartDate         *timestamppb.Timestamp `protobuf:"bytes,2,opt,name=start_date,json=startDate,proto3" json:"start_date,omitempty"`
	EndDate           *timestamppb.Timestamp `protobuf:"bytes,3,opt,name=end_date,json=endDate,proto3" json:"end_date,omitempty"`
	TimeAmountMinutes int64                  `protobuf:"varint,4,opt,name=time_amount_minutes,json=timeAmountMinutes,proto3" json:"time_amount_minutes,omitempty"`
	NumPages          int64                  `protobuf:"varint,5,opt,name=num_pages,json=numPages,proto3" json:"num_pages,omitempty"`
	GoalStatus        GoalStatus             `protobuf:"varint,6,opt,name=goal_status,json=goalStatus,proto3,enum=bookowl.GoalStatus" json:"goal_status,omitempty"`
	UserId            uint64                 `protobuf:"varint,7,opt,name=user_id,json=userId,proto3" json:"user_id,omitempty"`
}

func (x *GoalInfo) Reset() {
	*x = GoalInfo{}
	if protoimpl.UnsafeEnabled {
		mi := &file_goal_proto_msgTypes[6]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *GoalInfo) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*GoalInfo) ProtoMessage() {}

func (x *GoalInfo) ProtoReflect() protoreflect.Message {
	mi := &file_goal_proto_msgTypes[6]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use GoalInfo.ProtoReflect.Descriptor instead.
func (*GoalInfo) Descriptor() ([]byte, []int) {
	return file_goal_proto_rawDescGZIP(), []int{6}
}

func (x *GoalInfo) GetGoalId() uint64 {
	if x != nil {
		return x.GoalId
	}
	return 0
}

func (x *GoalInfo) GetStartDate() *timestamppb.Timestamp {
	if x != nil {
		return x.StartDate
	}
	return nil
}

func (x *GoalInfo) GetEndDate() *timestamppb.Timestamp {
	if x != nil {
		return x.EndDate
	}
	return nil
}

func (x *GoalInfo) GetTimeAmountMinutes() int64 {
	if x != nil {
		return x.TimeAmountMinutes
	}
	return 0
}

func (x *GoalInfo) GetNumPages() int64 {
	if x != nil {
		return x.NumPages
	}
	return 0
}

func (x *GoalInfo) GetGoalStatus() GoalStatus {
	if x != nil {
		return x.GoalStatus
	}
	return GoalStatus_GOAL_UNKNOWN
}

func (x *GoalInfo) GetUserId() uint64 {
	if x != nil {
		return x.UserId
	}
	return 0
}

var File_goal_proto protoreflect.FileDescriptor

var file_goal_proto_rawDesc = []byte{
	0x0a, 0x0a, 0x67, 0x6f, 0x61, 0x6c, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x07, 0x62, 0x6f,
	0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x1a, 0x1f, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x74, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0x45, 0x0a, 0x13, 0x52, 0x65, 0x67, 0x69, 0x73, 0x74,
	0x65, 0x72, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x2e, 0x0a,
	0x09, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x6e, 0x66, 0x6f, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b,
	0x32, 0x11, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x47, 0x6f, 0x61, 0x6c, 0x49,
	0x6e, 0x66, 0x6f, 0x52, 0x08, 0x67, 0x6f, 0x61, 0x6c, 0x49, 0x6e, 0x66, 0x6f, 0x22, 0x5f, 0x0a,
	0x14, 0x52, 0x65, 0x67, 0x69, 0x73, 0x74, 0x65, 0x72, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x73,
	0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x17, 0x0a, 0x07, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x64,
	0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x06, 0x67, 0x6f, 0x61, 0x6c, 0x49, 0x64, 0x12, 0x2e,
	0x0a, 0x04, 0x74, 0x69, 0x6d, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67,
	0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54,
	0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x04, 0x74, 0x69, 0x6d, 0x65, 0x22, 0x31,
	0x0a, 0x16, 0x47, 0x65, 0x74, 0x47, 0x6f, 0x61, 0x6c, 0x42, 0x79, 0x55, 0x73, 0x65, 0x72, 0x49,
	0x44, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x17, 0x0a, 0x07, 0x75, 0x73, 0x65, 0x72,
	0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x06, 0x75, 0x73, 0x65, 0x72, 0x49,
	0x64, 0x22, 0x71, 0x0a, 0x0f, 0x47, 0x65, 0x74, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x12, 0x2e, 0x0a, 0x09, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x6e, 0x66,
	0x6f, 0x18, 0x01, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x11, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77,
	0x6c, 0x2e, 0x47, 0x6f, 0x61, 0x6c, 0x49, 0x6e, 0x66, 0x6f, 0x52, 0x08, 0x67, 0x6f, 0x61, 0x6c,
	0x49, 0x6e, 0x66, 0x6f, 0x12, 0x2e, 0x0a, 0x04, 0x74, 0x69, 0x6d, 0x65, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74,
	0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x04,
	0x74, 0x69, 0x6d, 0x65, 0x22, 0x68, 0x0a, 0x17, 0x55, 0x70, 0x64, 0x61, 0x74, 0x65, 0x47, 0x6f,
	0x61, 0x6c, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12,
	0x17, 0x0a, 0x07, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x06, 0x67, 0x6f, 0x61, 0x6c, 0x49, 0x64, 0x12, 0x34, 0x0a, 0x0b, 0x67, 0x6f, 0x61, 0x6c,
	0x5f, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0e, 0x32, 0x13, 0x2e,
	0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x47, 0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61, 0x74,
	0x75, 0x73, 0x52, 0x0a, 0x67, 0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x22, 0x74,
	0x0a, 0x12, 0x55, 0x70, 0x64, 0x61, 0x74, 0x65, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x12, 0x2e, 0x0a, 0x09, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x6e, 0x66,
	0x6f, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x11, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77,
	0x6c, 0x2e, 0x47, 0x6f, 0x61, 0x6c, 0x49, 0x6e, 0x66, 0x6f, 0x52, 0x08, 0x67, 0x6f, 0x61, 0x6c,
	0x49, 0x6e, 0x66, 0x6f, 0x12, 0x2e, 0x0a, 0x04, 0x74, 0x69, 0x6d, 0x65, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74,
	0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x04,
	0x74, 0x69, 0x6d, 0x65, 0x22, 0xb1, 0x02, 0x0a, 0x08, 0x47, 0x6f, 0x61, 0x6c, 0x49, 0x6e, 0x66,
	0x6f, 0x12, 0x17, 0x0a, 0x07, 0x67, 0x6f, 0x61, 0x6c, 0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x04, 0x52, 0x06, 0x67, 0x6f, 0x61, 0x6c, 0x49, 0x64, 0x12, 0x39, 0x0a, 0x0a, 0x73, 0x74,
	0x61, 0x72, 0x74, 0x5f, 0x64, 0x61, 0x74, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a,
	0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66,
	0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x09, 0x73, 0x74, 0x61, 0x72,
	0x74, 0x44, 0x61, 0x74, 0x65, 0x12, 0x35, 0x0a, 0x08, 0x65, 0x6e, 0x64, 0x5f, 0x64, 0x61, 0x74,
	0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74,
	0x61, 0x6d, 0x70, 0x52, 0x07, 0x65, 0x6e, 0x64, 0x44, 0x61, 0x74, 0x65, 0x12, 0x2e, 0x0a, 0x13,
	0x74, 0x69, 0x6d, 0x65, 0x5f, 0x61, 0x6d, 0x6f, 0x75, 0x6e, 0x74, 0x5f, 0x6d, 0x69, 0x6e, 0x75,
	0x74, 0x65, 0x73, 0x18, 0x04, 0x20, 0x01, 0x28, 0x03, 0x52, 0x11, 0x74, 0x69, 0x6d, 0x65, 0x41,
	0x6d, 0x6f, 0x75, 0x6e, 0x74, 0x4d, 0x69, 0x6e, 0x75, 0x74, 0x65, 0x73, 0x12, 0x1b, 0x0a, 0x09,
	0x6e, 0x75, 0x6d, 0x5f, 0x70, 0x61, 0x67, 0x65, 0x73, 0x18, 0x05, 0x20, 0x01, 0x28, 0x03, 0x52,
	0x08, 0x6e, 0x75, 0x6d, 0x50, 0x61, 0x67, 0x65, 0x73, 0x12, 0x34, 0x0a, 0x0b, 0x67, 0x6f, 0x61,
	0x6c, 0x5f, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x18, 0x06, 0x20, 0x01, 0x28, 0x0e, 0x32, 0x13,
	0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x47, 0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61,
	0x74, 0x75, 0x73, 0x52, 0x0a, 0x67, 0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12,
	0x17, 0x0a, 0x07, 0x75, 0x73, 0x65, 0x72, 0x5f, 0x69, 0x64, 0x18, 0x07, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x06, 0x75, 0x73, 0x65, 0x72, 0x49, 0x64, 0x2a, 0x64, 0x0a, 0x0a, 0x47, 0x6f, 0x61, 0x6c,
	0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12, 0x10, 0x0a, 0x0c, 0x47, 0x4f, 0x41, 0x4c, 0x5f, 0x55,
	0x4e, 0x4b, 0x4e, 0x4f, 0x57, 0x4e, 0x10, 0x00, 0x12, 0x10, 0x0a, 0x0c, 0x47, 0x4f, 0x41, 0x4c,
	0x5f, 0x50, 0x45, 0x4e, 0x44, 0x49, 0x4e, 0x47, 0x10, 0x01, 0x12, 0x0e, 0x0a, 0x0a, 0x47, 0x4f,
	0x41, 0x4c, 0x5f, 0x44, 0x4f, 0x49, 0x4e, 0x47, 0x10, 0x02, 0x12, 0x11, 0x0a, 0x0d, 0x47, 0x4f,
	0x41, 0x4c, 0x5f, 0x43, 0x4f, 0x4d, 0x50, 0x4c, 0x45, 0x54, 0x45, 0x10, 0x03, 0x12, 0x0f, 0x0a,
	0x0b, 0x47, 0x4f, 0x41, 0x4c, 0x5f, 0x46, 0x41, 0x49, 0x4c, 0x45, 0x44, 0x10, 0x04, 0x32, 0xec,
	0x01, 0x0a, 0x04, 0x47, 0x6f, 0x61, 0x6c, 0x12, 0x47, 0x0a, 0x08, 0x52, 0x65, 0x67, 0x69, 0x73,
	0x74, 0x65, 0x72, 0x12, 0x1c, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x52, 0x65,
	0x67, 0x69, 0x73, 0x74, 0x65, 0x72, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x1a, 0x1d, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x52, 0x65, 0x67, 0x69,
	0x73, 0x74, 0x65, 0x72, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65,
	0x12, 0x48, 0x0a, 0x0b, 0x47, 0x65, 0x74, 0x42, 0x79, 0x55, 0x73, 0x65, 0x72, 0x49, 0x44, 0x12,
	0x1f, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x47, 0x65, 0x74, 0x47, 0x6f, 0x61,
	0x6c, 0x42, 0x79, 0x55, 0x73, 0x65, 0x72, 0x49, 0x44, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x1a, 0x18, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x47, 0x65, 0x74, 0x47, 0x6f,
	0x61, 0x6c, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x51, 0x0a, 0x10, 0x55, 0x70,
	0x64, 0x61, 0x74, 0x65, 0x47, 0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12, 0x20,
	0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x55, 0x70, 0x64, 0x61, 0x74, 0x65, 0x47,
	0x6f, 0x61, 0x6c, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x1a, 0x1b, 0x2e, 0x62, 0x6f, 0x6f, 0x6b, 0x6f, 0x77, 0x6c, 0x2e, 0x55, 0x70, 0x64, 0x61, 0x74,
	0x65, 0x47, 0x6f, 0x61, 0x6c, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x42, 0x26, 0x5a,
	0x24, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x6a, 0x70, 0x68, 0x61,
	0x63, 0x6b, 0x73, 0x2f, 0x42, 0x5f, 0x32, 0x31, 0x30, 0x39, 0x2f, 0x73, 0x65, 0x72, 0x76, 0x65,
	0x72, 0x2f, 0x61, 0x70, 0x69, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_goal_proto_rawDescOnce sync.Once
	file_goal_proto_rawDescData = file_goal_proto_rawDesc
)

func file_goal_proto_rawDescGZIP() []byte {
	file_goal_proto_rawDescOnce.Do(func() {
		file_goal_proto_rawDescData = protoimpl.X.CompressGZIP(file_goal_proto_rawDescData)
	})
	return file_goal_proto_rawDescData
}

var file_goal_proto_enumTypes = make([]protoimpl.EnumInfo, 1)
var file_goal_proto_msgTypes = make([]protoimpl.MessageInfo, 7)
var file_goal_proto_goTypes = []interface{}{
	(GoalStatus)(0),                 // 0: bookowl.GoalStatus
	(*RegisterGoalRequest)(nil),     // 1: bookowl.RegisterGoalRequest
	(*RegisterGoalResponse)(nil),    // 2: bookowl.RegisterGoalResponse
	(*GetGoalByUserIDRequest)(nil),  // 3: bookowl.GetGoalByUserIDRequest
	(*GetGoalResponse)(nil),         // 4: bookowl.GetGoalResponse
	(*UpdateGoalStatusRequest)(nil), // 5: bookowl.UpdateGoalStatusRequest
	(*UpdateGoalResponse)(nil),      // 6: bookowl.UpdateGoalResponse
	(*GoalInfo)(nil),                // 7: bookowl.GoalInfo
	(*timestamppb.Timestamp)(nil),   // 8: google.protobuf.Timestamp
}
var file_goal_proto_depIdxs = []int32{
	7,  // 0: bookowl.RegisterGoalRequest.goal_info:type_name -> bookowl.GoalInfo
	8,  // 1: bookowl.RegisterGoalResponse.time:type_name -> google.protobuf.Timestamp
	7,  // 2: bookowl.GetGoalResponse.goal_info:type_name -> bookowl.GoalInfo
	8,  // 3: bookowl.GetGoalResponse.time:type_name -> google.protobuf.Timestamp
	0,  // 4: bookowl.UpdateGoalStatusRequest.goal_status:type_name -> bookowl.GoalStatus
	7,  // 5: bookowl.UpdateGoalResponse.goal_info:type_name -> bookowl.GoalInfo
	8,  // 6: bookowl.UpdateGoalResponse.time:type_name -> google.protobuf.Timestamp
	8,  // 7: bookowl.GoalInfo.start_date:type_name -> google.protobuf.Timestamp
	8,  // 8: bookowl.GoalInfo.end_date:type_name -> google.protobuf.Timestamp
	0,  // 9: bookowl.GoalInfo.goal_status:type_name -> bookowl.GoalStatus
	1,  // 10: bookowl.Goal.Register:input_type -> bookowl.RegisterGoalRequest
	3,  // 11: bookowl.Goal.GetByUserID:input_type -> bookowl.GetGoalByUserIDRequest
	5,  // 12: bookowl.Goal.UpdateGoalStatus:input_type -> bookowl.UpdateGoalStatusRequest
	2,  // 13: bookowl.Goal.Register:output_type -> bookowl.RegisterGoalResponse
	4,  // 14: bookowl.Goal.GetByUserID:output_type -> bookowl.GetGoalResponse
	6,  // 15: bookowl.Goal.UpdateGoalStatus:output_type -> bookowl.UpdateGoalResponse
	13, // [13:16] is the sub-list for method output_type
	10, // [10:13] is the sub-list for method input_type
	10, // [10:10] is the sub-list for extension type_name
	10, // [10:10] is the sub-list for extension extendee
	0,  // [0:10] is the sub-list for field type_name
}

func init() { file_goal_proto_init() }
func file_goal_proto_init() {
	if File_goal_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_goal_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*RegisterGoalRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*RegisterGoalResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*GetGoalByUserIDRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*GetGoalResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*UpdateGoalStatusRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[5].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*UpdateGoalResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_goal_proto_msgTypes[6].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*GoalInfo); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_goal_proto_rawDesc,
			NumEnums:      1,
			NumMessages:   7,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_goal_proto_goTypes,
		DependencyIndexes: file_goal_proto_depIdxs,
		EnumInfos:         file_goal_proto_enumTypes,
		MessageInfos:      file_goal_proto_msgTypes,
	}.Build()
	File_goal_proto = out.File
	file_goal_proto_rawDesc = nil
	file_goal_proto_goTypes = nil
	file_goal_proto_depIdxs = nil
}
