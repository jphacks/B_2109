# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [protos/book.proto](#protos/book.proto)
    - [BookInfo](#bookowl.BookInfo)
    - [BookRegisterRequest](#bookowl.BookRegisterRequest)
    - [BookRegisterResponse](#bookowl.BookRegisterResponse)
    - [GetBookResponse](#bookowl.GetBookResponse)
    - [GetByBookmarkIDRequest](#bookowl.GetByBookmarkIDRequest)
    - [GetByUserIDRequest](#bookowl.GetByUserIDRequest)
    - [UpdateBookResponse](#bookowl.UpdateBookResponse)
    - [UpdateBookmarkIDRequest](#bookowl.UpdateBookmarkIDRequest)
    - [UpdateReadStatusRequest](#bookowl.UpdateReadStatusRequest)
  
    - [ReadStatus](#bookowl.ReadStatus)
  
    - [Book](#bookowl.Book)
  
- [protos/goal.proto](#protos/goal.proto)
    - [GetGoalByUserIDRequest](#bookowl.GetGoalByUserIDRequest)
    - [GetGoalResponse](#bookowl.GetGoalResponse)
    - [GoalInfo](#bookowl.GoalInfo)
    - [RegisterGoalRequest](#bookowl.RegisterGoalRequest)
    - [RegisterGoalResponse](#bookowl.RegisterGoalResponse)
    - [UpdateGoalResponse](#bookowl.UpdateGoalResponse)
    - [UpdateGoalStatusRequest](#bookowl.UpdateGoalStatusRequest)
  
    - [GoalStatus](#bookowl.GoalStatus)
  
    - [Goal](#bookowl.Goal)
  
- [protos/read_event.proto](#protos/read_event.proto)
    - [GetByBookIDRequest](#bookowl.GetByBookIDRequest)
    - [GetReadEventResponse](#bookowl.GetReadEventResponse)
    - [ReadEventInfo](#bookowl.ReadEventInfo)
    - [ReadEventRegisterRequest](#bookowl.ReadEventRegisterRequest)
    - [ReadEventRegisterResponse](#bookowl.ReadEventRegisterResponse)
  
    - [ReadEvent](#bookowl.ReadEvent)
  
- [Scalar Value Types](#scalar-value-types)



<a name="protos/book.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/book.proto



<a name="bookowl.BookInfo"></a>

### BookInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |
| isbn | [string](#string) |  |  |
| book_mili_width | [uint64](#uint64) |  |  |
| name | [string](#string) |  |  |
| pages | [int64](#int64) |  |  |
| price | [int64](#int64) |  |  |
| authors | [string](#string) | repeated |  |
| read_status | [ReadStatus](#bookowl.ReadStatus) |  |  |
| categories | [string](#string) | repeated |  |
| user_id | [uint64](#uint64) | repeated |  |
| bookmark_id | [uint64](#uint64) | repeated |  |






<a name="bookowl.BookRegisterRequest"></a>

### BookRegisterRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) |  |  |
| bookmark_id | [uint64](#uint64) |  |  |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.BookRegisterResponse"></a>

### BookRegisterResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetBookResponse"></a>

### GetBookResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) | repeated |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetByBookmarkIDRequest"></a>

### GetByBookmarkIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bookmark_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetByUserIDRequest"></a>

### GetByUserIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.UpdateBookResponse"></a>

### UpdateBookResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.UpdateBookmarkIDRequest"></a>

### UpdateBookmarkIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |
| bookmark_id | [uint64](#uint64) |  |  |






<a name="bookowl.UpdateReadStatusRequest"></a>

### UpdateReadStatusRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |
| read_status | [ReadStatus](#bookowl.ReadStatus) |  |  |





 


<a name="bookowl.ReadStatus"></a>

### ReadStatus
ReadStatus links to server/pkg/models/user_book.go ReadStatus

| Name | Number | Description |
| ---- | ------ | ----------- |
| READ_UNREAD | 0 |  |
| READ_READING | 1 |  |
| READ_SUSPENDED | 2 |  |
| READ_COMPLETE | 3 |  |


 

 


<a name="bookowl.Book"></a>

### Book


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Register | [BookRegisterRequest](#bookowl.BookRegisterRequest) | [BookRegisterResponse](#bookowl.BookRegisterResponse) | Registering Book using ISBN and a book width[mm]. |
| GetByUserID | [GetByUserIDRequest](#bookowl.GetByUserIDRequest) | [GetBookResponse](#bookowl.GetBookResponse) |  |
| GetByBookmarkID | [GetByBookmarkIDRequest](#bookowl.GetByBookmarkIDRequest) | [GetBookResponse](#bookowl.GetBookResponse) |  |
| UpdateBookmarkID | [UpdateBookmarkIDRequest](#bookowl.UpdateBookmarkIDRequest) | [UpdateBookResponse](#bookowl.UpdateBookResponse) |  |
| UpdateReadStatus | [UpdateReadStatusRequest](#bookowl.UpdateReadStatusRequest) | [UpdateBookResponse](#bookowl.UpdateBookResponse) |  |

 



<a name="protos/goal.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/goal.proto



<a name="bookowl.GetGoalByUserIDRequest"></a>

### GetGoalByUserIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetGoalResponse"></a>

### GetGoalResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_info | [GoalInfo](#bookowl.GoalInfo) | repeated |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GoalInfo"></a>

### GoalInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_id | [uint64](#uint64) |  |  |
| start_date | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| end_date | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| time_amount_minutes | [int64](#int64) |  |  |
| num_pages | [int64](#int64) |  |  |
| goal_status | [GoalStatus](#bookowl.GoalStatus) |  |  |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.RegisterGoalRequest"></a>

### RegisterGoalRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_info | [GoalInfo](#bookowl.GoalInfo) |  |  |






<a name="bookowl.RegisterGoalResponse"></a>

### RegisterGoalResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_id | [uint64](#uint64) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.UpdateGoalResponse"></a>

### UpdateGoalResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_info | [GoalInfo](#bookowl.GoalInfo) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.UpdateGoalStatusRequest"></a>

### UpdateGoalStatusRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_id | [uint64](#uint64) |  |  |
| goal_status | [GoalStatus](#bookowl.GoalStatus) |  |  |





 


<a name="bookowl.GoalStatus"></a>

### GoalStatus


| Name | Number | Description |
| ---- | ------ | ----------- |
| GOAL_PENDING | 0 |  |
| GOAL_DOING | 1 |  |
| GOAL_COMPLETE | 2 |  |
| GOAL_FAILED | 3 |  |


 

 


<a name="bookowl.Goal"></a>

### Goal


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Register | [RegisterGoalRequest](#bookowl.RegisterGoalRequest) | [RegisterGoalResponse](#bookowl.RegisterGoalResponse) |  |
| GetByUserID | [GetGoalByUserIDRequest](#bookowl.GetGoalByUserIDRequest) | [GetGoalResponse](#bookowl.GetGoalResponse) |  |
| UpdateGoalStatus | [UpdateGoalStatusRequest](#bookowl.UpdateGoalStatusRequest) | [UpdateGoalResponse](#bookowl.UpdateGoalResponse) |  |

 



<a name="protos/read_event.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/read_event.proto



<a name="bookowl.GetByBookIDRequest"></a>

### GetByBookIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetReadEventResponse"></a>

### GetReadEventResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_event_info | [ReadEventInfo](#bookowl.ReadEventInfo) | repeated |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.ReadEventInfo"></a>

### ReadEventInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_start_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_end_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_start_position | [int64](#int64) |  |  |
| read_end_position | [int64](#int64) |  |  |






<a name="bookowl.ReadEventRegisterRequest"></a>

### ReadEventRegisterRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_event_info | [ReadEventInfo](#bookowl.ReadEventInfo) |  |  |
| bookmark_id | [uint64](#uint64) |  |  |






<a name="bookowl.ReadEventRegisterResponse"></a>

### ReadEventRegisterResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_event_id | [uint64](#uint64) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |





 

 

 


<a name="bookowl.ReadEvent"></a>

### ReadEvent


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Register | [ReadEventRegisterRequest](#bookowl.ReadEventRegisterRequest) | [ReadEventRegisterResponse](#bookowl.ReadEventRegisterResponse) | Registering BookEvent with bookmark ID |
| GetByBookID | [GetByBookIDRequest](#bookowl.GetByBookIDRequest) | [GetReadEventResponse](#bookowl.GetReadEventResponse) |  |

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

