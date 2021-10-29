# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [protos/book.proto](#protos/book.proto)
    - [BookInfo](#bookowl.BookInfo)
    - [GetBooksByBookmarkIDRequest](#bookowl.GetBooksByBookmarkIDRequest)
    - [GetBooksByUserIDRequest](#bookowl.GetBooksByUserIDRequest)
    - [GetBooksResponse](#bookowl.GetBooksResponse)
    - [GetProgressByUserIDRequest](#bookowl.GetProgressByUserIDRequest)
    - [GetProgressByUserIDResponse](#bookowl.GetProgressByUserIDResponse)
    - [GetProgressByUserIDWithDurationRequest](#bookowl.GetProgressByUserIDWithDurationRequest)
    - [GetProgressByUserIDWithDurationResponse](#bookowl.GetProgressByUserIDWithDurationResponse)
    - [RegisterBookRequest](#bookowl.RegisterBookRequest)
    - [RegisterBookResponse](#bookowl.RegisterBookResponse)
    - [UpdateBookResponse](#bookowl.UpdateBookResponse)
    - [UpdateBookmarkIDRequest](#bookowl.UpdateBookmarkIDRequest)
    - [UpdateReadStatusRequest](#bookowl.UpdateReadStatusRequest)
  
    - [ReadStatus](#bookowl.ReadStatus)
  
    - [Book](#bookowl.Book)
  
- [protos/goal.proto](#protos/goal.proto)
    - [CreateGoalRequest](#bookowl.CreateGoalRequest)
    - [CreateGoalResponse](#bookowl.CreateGoalResponse)
    - [GetGoalByUserIDRequest](#bookowl.GetGoalByUserIDRequest)
    - [GetGoalsResponse](#bookowl.GetGoalsResponse)
    - [GoalInfo](#bookowl.GoalInfo)
    - [UpdateGoalResponse](#bookowl.UpdateGoalResponse)
    - [UpdateGoalStatusRequest](#bookowl.UpdateGoalStatusRequest)
  
    - [GoalStatus](#bookowl.GoalStatus)
  
    - [Goal](#bookowl.Goal)
  
- [protos/read_event.proto](#protos/read_event.proto)
    - [CreateReadEventRequest](#bookowl.CreateReadEventRequest)
    - [CreateReadEventResponse](#bookowl.CreateReadEventResponse)
    - [GetReadEventsByBookIDRequest](#bookowl.GetReadEventsByBookIDRequest)
    - [GetReadEventsResponse](#bookowl.GetReadEventsResponse)
    - [ReadEventInfo](#bookowl.ReadEventInfo)
  
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
| name | [string](#string) |  |  |
| pages | [int64](#int64) |  |  |
| width_level | [int64](#int64) |  |  |
| price | [int64](#int64) |  |  |
| authors | [string](#string) | repeated |  |
| read_status | [ReadStatus](#bookowl.ReadStatus) |  |  |
| categories | [string](#string) | repeated |  |
| user_id | [uint64](#uint64) |  |  |
| bookmark_id | [uint64](#uint64) |  |  |
| book_thumbnail | [string](#string) |  |  |






<a name="bookowl.GetBooksByBookmarkIDRequest"></a>

### GetBooksByBookmarkIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bookmark_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetBooksByUserIDRequest"></a>

### GetBooksByUserIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetBooksResponse"></a>

### GetBooksResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| books_info | [BookInfo](#bookowl.BookInfo) | repeated |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetProgressByUserIDRequest"></a>

### GetProgressByUserIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetProgressByUserIDResponse"></a>

### GetProgressByUserIDResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| progress | [float](#float) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetProgressByUserIDWithDurationRequest"></a>

### GetProgressByUserIDWithDurationRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |
| start | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| end | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetProgressByUserIDWithDurationResponse"></a>

### GetProgressByUserIDWithDurationResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| progress | [float](#float) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.RegisterBookRequest"></a>

### RegisterBookRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) |  |  |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.RegisterBookResponse"></a>

### RegisterBookResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






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
| READ_UNSPECIFIED | 0 |  |
| READ_UNREAD | 1 |  |
| READ_READING | 2 |  |
| READ_SUSPENDED | 3 |  |
| READ_COMPLETE | 4 |  |


 

 


<a name="bookowl.Book"></a>

### Book


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| RegisterBook | [RegisterBookRequest](#bookowl.RegisterBookRequest) | [RegisterBookResponse](#bookowl.RegisterBookResponse) | Registering Book |
| GetBooksByUserID | [GetBooksByUserIDRequest](#bookowl.GetBooksByUserIDRequest) | [GetBooksResponse](#bookowl.GetBooksResponse) |  |
| GetBooksByBookmarkID | [GetBooksByBookmarkIDRequest](#bookowl.GetBooksByBookmarkIDRequest) | [GetBooksResponse](#bookowl.GetBooksResponse) |  |
| UpdateBookmarkID | [UpdateBookmarkIDRequest](#bookowl.UpdateBookmarkIDRequest) | [UpdateBookResponse](#bookowl.UpdateBookResponse) |  |
| UpdateReadStatus | [UpdateReadStatusRequest](#bookowl.UpdateReadStatusRequest) | [UpdateBookResponse](#bookowl.UpdateBookResponse) |  |
| GetProgressByUserID | [GetProgressByUserIDRequest](#bookowl.GetProgressByUserIDRequest) | [GetProgressByUserIDResponse](#bookowl.GetProgressByUserIDResponse) |  |
| GetProgressByUserIDWithDuration | [GetProgressByUserIDWithDurationRequest](#bookowl.GetProgressByUserIDWithDurationRequest) | [GetProgressByUserIDWithDurationResponse](#bookowl.GetProgressByUserIDWithDurationResponse) |  |

 



<a name="protos/goal.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/goal.proto



<a name="bookowl.CreateGoalRequest"></a>

### CreateGoalRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_info | [GoalInfo](#bookowl.GoalInfo) |  |  |






<a name="bookowl.CreateGoalResponse"></a>

### CreateGoalResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goal_id | [uint64](#uint64) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetGoalByUserIDRequest"></a>

### GetGoalByUserIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetGoalsResponse"></a>

### GetGoalsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| goals_info | [GoalInfo](#bookowl.GoalInfo) | repeated |  |
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
| GOAL_UNKNOWN | 0 |  |
| GOAL_PENDING | 1 |  |
| GOAL_DOING | 2 |  |
| GOAL_COMPLETE | 3 |  |
| GOAL_FAILED | 4 |  |


 

 


<a name="bookowl.Goal"></a>

### Goal


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| CreateGoal | [CreateGoalRequest](#bookowl.CreateGoalRequest) | [CreateGoalResponse](#bookowl.CreateGoalResponse) |  |
| GetByUserID | [GetGoalByUserIDRequest](#bookowl.GetGoalByUserIDRequest) | [GetGoalsResponse](#bookowl.GetGoalsResponse) |  |
| UpdateGoalStatus | [UpdateGoalStatusRequest](#bookowl.UpdateGoalStatusRequest) | [UpdateGoalResponse](#bookowl.UpdateGoalResponse) |  |

 



<a name="protos/read_event.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/read_event.proto



<a name="bookowl.CreateReadEventRequest"></a>

### CreateReadEventRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_event_info | [ReadEventInfo](#bookowl.ReadEventInfo) |  |  |
| bookmark_id | [uint64](#uint64) |  |  |






<a name="bookowl.CreateReadEventResponse"></a>

### CreateReadEventResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_event_id | [uint64](#uint64) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.GetReadEventsByBookIDRequest"></a>

### GetReadEventsByBookIDRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [uint64](#uint64) |  |  |






<a name="bookowl.GetReadEventsResponse"></a>

### GetReadEventsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_events_info | [ReadEventInfo](#bookowl.ReadEventInfo) | repeated |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |






<a name="bookowl.ReadEventInfo"></a>

### ReadEventInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_start_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_end_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_start_width_revel | [int64](#int64) |  |  |
| read_end_width_level | [int64](#int64) |  |  |





 

 

 


<a name="bookowl.ReadEvent"></a>

### ReadEvent


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| CreateReadEvent | [CreateReadEventRequest](#bookowl.CreateReadEventRequest) | [CreateReadEventResponse](#bookowl.CreateReadEventResponse) |  |
| GetReadEventsByBookID | [GetReadEventsByBookIDRequest](#bookowl.GetReadEventsByBookIDRequest) | [GetReadEventsResponse](#bookowl.GetReadEventsResponse) |  |

 



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

