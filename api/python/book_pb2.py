# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: book.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import timestamp_pb2 as google_dot_protobuf_dot_timestamp__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='book.proto',
  package='bookowl',
  syntax='proto3',
  serialized_options=b'Z$github.com/jphacks/B_2109/server/api',
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\nbook.proto\x12\x07\x62ookowl\x1a\x1fgoogle/protobuf/timestamp.proto\"L\n\x13RegisterBookRequest\x12$\n\tbook_info\x18\x01 \x01(\x0b\x32\x11.bookowl.BookInfo\x12\x0f\n\x07user_id\x18\x02 \x01(\x04\"f\n\x14RegisterBookResponse\x12$\n\tbook_info\x18\x01 \x01(\x0b\x32\x11.bookowl.BookInfo\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"*\n\x17GetBooksByUserIDRequest\x12\x0f\n\x07user_id\x18\x01 \x01(\x04\"2\n\x1bGetBooksByBookmarkIDRequest\x12\x13\n\x0b\x62ookmark_id\x18\x01 \x01(\x04\"c\n\x10GetBooksResponse\x12%\n\nbooks_info\x18\x01 \x03(\x0b\x32\x11.bookowl.BookInfo\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"T\n\x17UpdateReadStatusRequest\x12\x0f\n\x07\x62ook_id\x18\x01 \x01(\x04\x12(\n\x0bread_status\x18\x02 \x01(\x0e\x32\x13.bookowl.ReadStatus\"?\n\x17UpdateBookmarkIDRequest\x12\x0f\n\x07\x62ook_id\x18\x01 \x01(\x04\x12\x13\n\x0b\x62ookmark_id\x18\x02 \x01(\x04\"d\n\x12UpdateBookResponse\x12$\n\tbook_info\x18\x01 \x01(\x0b\x32\x11.bookowl.BookInfo\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"-\n\x1aGetProgressByUserIDRequest\x12\x0f\n\x07user_id\x18\x01 \x01(\x04\"Y\n\x1bGetProgressByUserIDResponse\x12\x10\n\x08progress\x18\x01 \x01(\x02\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"\x8d\x01\n&GetProgressByUserIDWithDurationRequest\x12\x0f\n\x07user_id\x18\x01 \x01(\x04\x12)\n\x05start\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12\'\n\x03\x65nd\x18\x03 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"e\n\'GetProgressByUserIDWithDurationResponse\x12\x10\n\x08progress\x18\x01 \x01(\x02\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"\xf7\x01\n\x08\x42ookInfo\x12\x0f\n\x07\x62ook_id\x18\x01 \x01(\x04\x12\x0c\n\x04isbn\x18\x02 \x01(\t\x12\x0c\n\x04name\x18\x03 \x01(\t\x12\r\n\x05pages\x18\x04 \x01(\x03\x12\x13\n\x0bwidth_level\x18\x05 \x01(\x03\x12\r\n\x05price\x18\x06 \x01(\x03\x12\x0f\n\x07\x61uthors\x18\x07 \x03(\t\x12(\n\x0bread_status\x18\x08 \x01(\x0e\x32\x13.bookowl.ReadStatus\x12\x12\n\ncategories\x18\t \x03(\t\x12\x0f\n\x07user_id\x18\n \x01(\x04\x12\x13\n\x0b\x62ookmark_id\x18\x0b \x01(\x04\x12\x16\n\x0e\x62ook_thumbnail\x18\x0c \x01(\t*l\n\nReadStatus\x12\x14\n\x10READ_UNSPECIFIED\x10\x00\x12\x0f\n\x0bREAD_UNREAD\x10\x01\x12\x10\n\x0cREAD_READING\x10\x02\x12\x12\n\x0eREAD_SUSPENDED\x10\x03\x12\x11\n\rREAD_COMPLETE\x10\x04\x32\x8c\x05\n\x04\x42ook\x12K\n\x0cRegisterBook\x12\x1c.bookowl.RegisterBookRequest\x1a\x1d.bookowl.RegisterBookResponse\x12O\n\x10GetBooksByUserID\x12 .bookowl.GetBooksByUserIDRequest\x1a\x19.bookowl.GetBooksResponse\x12W\n\x14GetBooksByBookmarkID\x12$.bookowl.GetBooksByBookmarkIDRequest\x1a\x19.bookowl.GetBooksResponse\x12Q\n\x10UpdateBookmarkID\x12 .bookowl.UpdateBookmarkIDRequest\x1a\x1b.bookowl.UpdateBookResponse\x12Q\n\x10UpdateReadStatus\x12 .bookowl.UpdateReadStatusRequest\x1a\x1b.bookowl.UpdateBookResponse\x12`\n\x13GetProgressByUserID\x12#.bookowl.GetProgressByUserIDRequest\x1a$.bookowl.GetProgressByUserIDResponse\x12\x84\x01\n\x1fGetProgressByUserIDWithDuration\x12/.bookowl.GetProgressByUserIDWithDurationRequest\x1a\x30.bookowl.GetProgressByUserIDWithDurationResponseB&Z$github.com/jphacks/B_2109/server/apib\x06proto3'
  ,
  dependencies=[google_dot_protobuf_dot_timestamp__pb2.DESCRIPTOR,])

_READSTATUS = _descriptor.EnumDescriptor(
  name='ReadStatus',
  full_name='bookowl.ReadStatus',
  filename=None,
  file=DESCRIPTOR,
  create_key=_descriptor._internal_create_key,
  values=[
    _descriptor.EnumValueDescriptor(
      name='READ_UNSPECIFIED', index=0, number=0,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_UNREAD', index=1, number=1,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_READING', index=2, number=2,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_SUSPENDED', index=3, number=3,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_COMPLETE', index=4, number=4,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
  ],
  containing_type=None,
  serialized_options=None,
  serialized_start=1323,
  serialized_end=1431,
)
_sym_db.RegisterEnumDescriptor(_READSTATUS)

ReadStatus = enum_type_wrapper.EnumTypeWrapper(_READSTATUS)
READ_UNSPECIFIED = 0
READ_UNREAD = 1
READ_READING = 2
READ_SUSPENDED = 3
READ_COMPLETE = 4



_REGISTERBOOKREQUEST = _descriptor.Descriptor(
  name='RegisterBookRequest',
  full_name='bookowl.RegisterBookRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_info', full_name='bookowl.RegisterBookRequest.book_info', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='user_id', full_name='bookowl.RegisterBookRequest.user_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=56,
  serialized_end=132,
)


_REGISTERBOOKRESPONSE = _descriptor.Descriptor(
  name='RegisterBookResponse',
  full_name='bookowl.RegisterBookResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_info', full_name='bookowl.RegisterBookResponse.book_info', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.RegisterBookResponse.time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=134,
  serialized_end=236,
)


_GETBOOKSBYUSERIDREQUEST = _descriptor.Descriptor(
  name='GetBooksByUserIDRequest',
  full_name='bookowl.GetBooksByUserIDRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='user_id', full_name='bookowl.GetBooksByUserIDRequest.user_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=238,
  serialized_end=280,
)


_GETBOOKSBYBOOKMARKIDREQUEST = _descriptor.Descriptor(
  name='GetBooksByBookmarkIDRequest',
  full_name='bookowl.GetBooksByBookmarkIDRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='bookmark_id', full_name='bookowl.GetBooksByBookmarkIDRequest.bookmark_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=282,
  serialized_end=332,
)


_GETBOOKSRESPONSE = _descriptor.Descriptor(
  name='GetBooksResponse',
  full_name='bookowl.GetBooksResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='books_info', full_name='bookowl.GetBooksResponse.books_info', index=0,
      number=1, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.GetBooksResponse.time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=334,
  serialized_end=433,
)


_UPDATEREADSTATUSREQUEST = _descriptor.Descriptor(
  name='UpdateReadStatusRequest',
  full_name='bookowl.UpdateReadStatusRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_id', full_name='bookowl.UpdateReadStatusRequest.book_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='read_status', full_name='bookowl.UpdateReadStatusRequest.read_status', index=1,
      number=2, type=14, cpp_type=8, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=435,
  serialized_end=519,
)


_UPDATEBOOKMARKIDREQUEST = _descriptor.Descriptor(
  name='UpdateBookmarkIDRequest',
  full_name='bookowl.UpdateBookmarkIDRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_id', full_name='bookowl.UpdateBookmarkIDRequest.book_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='bookmark_id', full_name='bookowl.UpdateBookmarkIDRequest.bookmark_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=521,
  serialized_end=584,
)


_UPDATEBOOKRESPONSE = _descriptor.Descriptor(
  name='UpdateBookResponse',
  full_name='bookowl.UpdateBookResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_info', full_name='bookowl.UpdateBookResponse.book_info', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.UpdateBookResponse.time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=586,
  serialized_end=686,
)


_GETPROGRESSBYUSERIDREQUEST = _descriptor.Descriptor(
  name='GetProgressByUserIDRequest',
  full_name='bookowl.GetProgressByUserIDRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='user_id', full_name='bookowl.GetProgressByUserIDRequest.user_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=688,
  serialized_end=733,
)


_GETPROGRESSBYUSERIDRESPONSE = _descriptor.Descriptor(
  name='GetProgressByUserIDResponse',
  full_name='bookowl.GetProgressByUserIDResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='progress', full_name='bookowl.GetProgressByUserIDResponse.progress', index=0,
      number=1, type=2, cpp_type=6, label=1,
      has_default_value=False, default_value=float(0),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.GetProgressByUserIDResponse.time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=735,
  serialized_end=824,
)


_GETPROGRESSBYUSERIDWITHDURATIONREQUEST = _descriptor.Descriptor(
  name='GetProgressByUserIDWithDurationRequest',
  full_name='bookowl.GetProgressByUserIDWithDurationRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='user_id', full_name='bookowl.GetProgressByUserIDWithDurationRequest.user_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='start', full_name='bookowl.GetProgressByUserIDWithDurationRequest.start', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='end', full_name='bookowl.GetProgressByUserIDWithDurationRequest.end', index=2,
      number=3, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=827,
  serialized_end=968,
)


_GETPROGRESSBYUSERIDWITHDURATIONRESPONSE = _descriptor.Descriptor(
  name='GetProgressByUserIDWithDurationResponse',
  full_name='bookowl.GetProgressByUserIDWithDurationResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='progress', full_name='bookowl.GetProgressByUserIDWithDurationResponse.progress', index=0,
      number=1, type=2, cpp_type=6, label=1,
      has_default_value=False, default_value=float(0),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.GetProgressByUserIDWithDurationResponse.time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=970,
  serialized_end=1071,
)


_BOOKINFO = _descriptor.Descriptor(
  name='BookInfo',
  full_name='bookowl.BookInfo',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_id', full_name='bookowl.BookInfo.book_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='isbn', full_name='bookowl.BookInfo.isbn', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='name', full_name='bookowl.BookInfo.name', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='pages', full_name='bookowl.BookInfo.pages', index=3,
      number=4, type=3, cpp_type=2, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='width_level', full_name='bookowl.BookInfo.width_level', index=4,
      number=5, type=3, cpp_type=2, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='price', full_name='bookowl.BookInfo.price', index=5,
      number=6, type=3, cpp_type=2, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='authors', full_name='bookowl.BookInfo.authors', index=6,
      number=7, type=9, cpp_type=9, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='read_status', full_name='bookowl.BookInfo.read_status', index=7,
      number=8, type=14, cpp_type=8, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='categories', full_name='bookowl.BookInfo.categories', index=8,
      number=9, type=9, cpp_type=9, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='user_id', full_name='bookowl.BookInfo.user_id', index=9,
      number=10, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='bookmark_id', full_name='bookowl.BookInfo.bookmark_id', index=10,
      number=11, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='book_thumbnail', full_name='bookowl.BookInfo.book_thumbnail', index=11,
      number=12, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=1074,
  serialized_end=1321,
)

_REGISTERBOOKREQUEST.fields_by_name['book_info'].message_type = _BOOKINFO
_REGISTERBOOKRESPONSE.fields_by_name['book_info'].message_type = _BOOKINFO
_REGISTERBOOKRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETBOOKSRESPONSE.fields_by_name['books_info'].message_type = _BOOKINFO
_GETBOOKSRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_UPDATEREADSTATUSREQUEST.fields_by_name['read_status'].enum_type = _READSTATUS
_UPDATEBOOKRESPONSE.fields_by_name['book_info'].message_type = _BOOKINFO
_UPDATEBOOKRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETPROGRESSBYUSERIDRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETPROGRESSBYUSERIDWITHDURATIONREQUEST.fields_by_name['start'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETPROGRESSBYUSERIDWITHDURATIONREQUEST.fields_by_name['end'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETPROGRESSBYUSERIDWITHDURATIONRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_BOOKINFO.fields_by_name['read_status'].enum_type = _READSTATUS
DESCRIPTOR.message_types_by_name['RegisterBookRequest'] = _REGISTERBOOKREQUEST
DESCRIPTOR.message_types_by_name['RegisterBookResponse'] = _REGISTERBOOKRESPONSE
DESCRIPTOR.message_types_by_name['GetBooksByUserIDRequest'] = _GETBOOKSBYUSERIDREQUEST
DESCRIPTOR.message_types_by_name['GetBooksByBookmarkIDRequest'] = _GETBOOKSBYBOOKMARKIDREQUEST
DESCRIPTOR.message_types_by_name['GetBooksResponse'] = _GETBOOKSRESPONSE
DESCRIPTOR.message_types_by_name['UpdateReadStatusRequest'] = _UPDATEREADSTATUSREQUEST
DESCRIPTOR.message_types_by_name['UpdateBookmarkIDRequest'] = _UPDATEBOOKMARKIDREQUEST
DESCRIPTOR.message_types_by_name['UpdateBookResponse'] = _UPDATEBOOKRESPONSE
DESCRIPTOR.message_types_by_name['GetProgressByUserIDRequest'] = _GETPROGRESSBYUSERIDREQUEST
DESCRIPTOR.message_types_by_name['GetProgressByUserIDResponse'] = _GETPROGRESSBYUSERIDRESPONSE
DESCRIPTOR.message_types_by_name['GetProgressByUserIDWithDurationRequest'] = _GETPROGRESSBYUSERIDWITHDURATIONREQUEST
DESCRIPTOR.message_types_by_name['GetProgressByUserIDWithDurationResponse'] = _GETPROGRESSBYUSERIDWITHDURATIONRESPONSE
DESCRIPTOR.message_types_by_name['BookInfo'] = _BOOKINFO
DESCRIPTOR.enum_types_by_name['ReadStatus'] = _READSTATUS
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

RegisterBookRequest = _reflection.GeneratedProtocolMessageType('RegisterBookRequest', (_message.Message,), {
  'DESCRIPTOR' : _REGISTERBOOKREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.RegisterBookRequest)
  })
_sym_db.RegisterMessage(RegisterBookRequest)

RegisterBookResponse = _reflection.GeneratedProtocolMessageType('RegisterBookResponse', (_message.Message,), {
  'DESCRIPTOR' : _REGISTERBOOKRESPONSE,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.RegisterBookResponse)
  })
_sym_db.RegisterMessage(RegisterBookResponse)

GetBooksByUserIDRequest = _reflection.GeneratedProtocolMessageType('GetBooksByUserIDRequest', (_message.Message,), {
  'DESCRIPTOR' : _GETBOOKSBYUSERIDREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetBooksByUserIDRequest)
  })
_sym_db.RegisterMessage(GetBooksByUserIDRequest)

GetBooksByBookmarkIDRequest = _reflection.GeneratedProtocolMessageType('GetBooksByBookmarkIDRequest', (_message.Message,), {
  'DESCRIPTOR' : _GETBOOKSBYBOOKMARKIDREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetBooksByBookmarkIDRequest)
  })
_sym_db.RegisterMessage(GetBooksByBookmarkIDRequest)

GetBooksResponse = _reflection.GeneratedProtocolMessageType('GetBooksResponse', (_message.Message,), {
  'DESCRIPTOR' : _GETBOOKSRESPONSE,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetBooksResponse)
  })
_sym_db.RegisterMessage(GetBooksResponse)

UpdateReadStatusRequest = _reflection.GeneratedProtocolMessageType('UpdateReadStatusRequest', (_message.Message,), {
  'DESCRIPTOR' : _UPDATEREADSTATUSREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.UpdateReadStatusRequest)
  })
_sym_db.RegisterMessage(UpdateReadStatusRequest)

UpdateBookmarkIDRequest = _reflection.GeneratedProtocolMessageType('UpdateBookmarkIDRequest', (_message.Message,), {
  'DESCRIPTOR' : _UPDATEBOOKMARKIDREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.UpdateBookmarkIDRequest)
  })
_sym_db.RegisterMessage(UpdateBookmarkIDRequest)

UpdateBookResponse = _reflection.GeneratedProtocolMessageType('UpdateBookResponse', (_message.Message,), {
  'DESCRIPTOR' : _UPDATEBOOKRESPONSE,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.UpdateBookResponse)
  })
_sym_db.RegisterMessage(UpdateBookResponse)

GetProgressByUserIDRequest = _reflection.GeneratedProtocolMessageType('GetProgressByUserIDRequest', (_message.Message,), {
  'DESCRIPTOR' : _GETPROGRESSBYUSERIDREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetProgressByUserIDRequest)
  })
_sym_db.RegisterMessage(GetProgressByUserIDRequest)

GetProgressByUserIDResponse = _reflection.GeneratedProtocolMessageType('GetProgressByUserIDResponse', (_message.Message,), {
  'DESCRIPTOR' : _GETPROGRESSBYUSERIDRESPONSE,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetProgressByUserIDResponse)
  })
_sym_db.RegisterMessage(GetProgressByUserIDResponse)

GetProgressByUserIDWithDurationRequest = _reflection.GeneratedProtocolMessageType('GetProgressByUserIDWithDurationRequest', (_message.Message,), {
  'DESCRIPTOR' : _GETPROGRESSBYUSERIDWITHDURATIONREQUEST,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetProgressByUserIDWithDurationRequest)
  })
_sym_db.RegisterMessage(GetProgressByUserIDWithDurationRequest)

GetProgressByUserIDWithDurationResponse = _reflection.GeneratedProtocolMessageType('GetProgressByUserIDWithDurationResponse', (_message.Message,), {
  'DESCRIPTOR' : _GETPROGRESSBYUSERIDWITHDURATIONRESPONSE,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetProgressByUserIDWithDurationResponse)
  })
_sym_db.RegisterMessage(GetProgressByUserIDWithDurationResponse)

BookInfo = _reflection.GeneratedProtocolMessageType('BookInfo', (_message.Message,), {
  'DESCRIPTOR' : _BOOKINFO,
  '__module__' : 'book_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.BookInfo)
  })
_sym_db.RegisterMessage(BookInfo)


DESCRIPTOR._options = None

_BOOK = _descriptor.ServiceDescriptor(
  name='Book',
  full_name='bookowl.Book',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=1434,
  serialized_end=2086,
  methods=[
  _descriptor.MethodDescriptor(
    name='RegisterBook',
    full_name='bookowl.Book.RegisterBook',
    index=0,
    containing_service=None,
    input_type=_REGISTERBOOKREQUEST,
    output_type=_REGISTERBOOKRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetBooksByUserID',
    full_name='bookowl.Book.GetBooksByUserID',
    index=1,
    containing_service=None,
    input_type=_GETBOOKSBYUSERIDREQUEST,
    output_type=_GETBOOKSRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetBooksByBookmarkID',
    full_name='bookowl.Book.GetBooksByBookmarkID',
    index=2,
    containing_service=None,
    input_type=_GETBOOKSBYBOOKMARKIDREQUEST,
    output_type=_GETBOOKSRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='UpdateBookmarkID',
    full_name='bookowl.Book.UpdateBookmarkID',
    index=3,
    containing_service=None,
    input_type=_UPDATEBOOKMARKIDREQUEST,
    output_type=_UPDATEBOOKRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='UpdateReadStatus',
    full_name='bookowl.Book.UpdateReadStatus',
    index=4,
    containing_service=None,
    input_type=_UPDATEREADSTATUSREQUEST,
    output_type=_UPDATEBOOKRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetProgressByUserID',
    full_name='bookowl.Book.GetProgressByUserID',
    index=5,
    containing_service=None,
    input_type=_GETPROGRESSBYUSERIDREQUEST,
    output_type=_GETPROGRESSBYUSERIDRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetProgressByUserIDWithDuration',
    full_name='bookowl.Book.GetProgressByUserIDWithDuration',
    index=6,
    containing_service=None,
    input_type=_GETPROGRESSBYUSERIDWITHDURATIONREQUEST,
    output_type=_GETPROGRESSBYUSERIDWITHDURATIONRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_BOOK)

DESCRIPTOR.services_by_name['Book'] = _BOOK

# @@protoc_insertion_point(module_scope)
