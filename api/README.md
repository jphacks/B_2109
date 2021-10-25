# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [protos/book.proto](#protos/book.proto)
    - [BookInfo](#bookowl.BookInfo)
    - [BookRegisterRequest](#bookowl.BookRegisterRequest)
    - [BookRegisterResponse](#bookowl.BookRegisterResponse)
  
    - [Book](#bookowl.Book)
  
- [protos/book_event.proto](#protos/book_event.proto)
    - [BookEventInfo](#bookowl.BookEventInfo)
    - [BookEventRegisterRequest](#bookowl.BookEventRegisterRequest)
    - [BookEventRegisterResponse](#bookowl.BookEventRegisterResponse)
  
    - [BookEvent](#bookowl.BookEvent)
  
- [Scalar Value Types](#scalar-value-types)



<a name="protos/book.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/book.proto



<a name="bookowl.BookInfo"></a>

### BookInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| isbn | [string](#string) |  |  |
| book_mili_width | [int64](#int64) |  |  |






<a name="bookowl.BookRegisterRequest"></a>

### BookRegisterRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_info | [BookInfo](#bookowl.BookInfo) |  |  |
| bookmark_id | [string](#string) |  |  |
| user_id | [string](#string) |  |  |






<a name="bookowl.BookRegisterResponse"></a>

### BookRegisterResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| book_id | [string](#string) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |





 

 

 


<a name="bookowl.Book"></a>

### Book


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Register | [BookRegisterRequest](#bookowl.BookRegisterRequest) | [BookRegisterResponse](#bookowl.BookRegisterResponse) | Registering Book using ISBN and a book width[mm]. |

 



<a name="protos/book_event.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/book_event.proto



<a name="bookowl.BookEventInfo"></a>

### BookEventInfo



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| read_start_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_end_time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |
| read_start_position | [int64](#int64) |  |  |
| read_end_position | [int64](#int64) |  |  |






<a name="bookowl.BookEventRegisterRequest"></a>

### BookEventRegisterRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bookevent_info | [BookEventInfo](#bookowl.BookEventInfo) |  |  |
| bookmark_id | [string](#string) |  |  |






<a name="bookowl.BookEventRegisterResponse"></a>

### BookEventRegisterResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bookevent_id | [string](#string) |  |  |
| time | [google.protobuf.Timestamp](#google.protobuf.Timestamp) |  |  |





 

 

 


<a name="bookowl.BookEvent"></a>

### BookEvent


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Register | [BookEventRegisterRequest](#bookowl.BookEventRegisterRequest) | [BookEventRegisterResponse](#bookowl.BookEventRegisterResponse) | Registering BookEvent with bookmark ID |

 



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

