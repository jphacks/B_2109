# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: read_event.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import timestamp_pb2 as google_dot_protobuf_dot_timestamp__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='read_event.proto',
  package='bookowl',
  syntax='proto3',
  serialized_options=b'Z$github.com/jphacks/B_2109/server/api',
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x10read_event.proto\x12\x07\x62ookowl\x1a\x1fgoogle/protobuf/timestamp.proto\"^\n\x16\x43reateReadEventRequest\x12/\n\x0fread_event_info\x18\x01 \x01(\x0b\x32\x16.bookowl.ReadEventInfo\x12\x13\n\x0b\x62ookmark_id\x18\x02 \x01(\x04\"Z\n\x17\x43reateReadEventResponse\x12\x15\n\rread_event_id\x18\x01 \x01(\x04\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"/\n\x1cGetReadEventsByBookIDRequest\x12\x0f\n\x07\x62ook_id\x18\x01 \x01(\x04\"s\n\x15GetReadEventsResponse\x12\x30\n\x10read_events_info\x18\x01 \x03(\x0b\x32\x16.bookowl.ReadEventInfo\x12(\n\x04time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"\xb5\x01\n\rReadEventInfo\x12\x33\n\x0fread_start_time\x18\x01 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12\x31\n\rread_end_time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12\x1e\n\x16read_start_width_revel\x18\x03 \x01(\x03\x12\x1c\n\x14read_end_width_level\x18\x04 \x01(\x03\x32\xc1\x01\n\tReadEvent\x12T\n\x0f\x43reateReadEvent\x12\x1f.bookowl.CreateReadEventRequest\x1a .bookowl.CreateReadEventResponse\x12^\n\x15GetReadEventsByBookID\x12%.bookowl.GetReadEventsByBookIDRequest\x1a\x1e.bookowl.GetReadEventsResponseB&Z$github.com/jphacks/B_2109/server/apib\x06proto3'
  ,
  dependencies=[google_dot_protobuf_dot_timestamp__pb2.DESCRIPTOR,])




_CREATEREADEVENTREQUEST = _descriptor.Descriptor(
  name='CreateReadEventRequest',
  full_name='bookowl.CreateReadEventRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='read_event_info', full_name='bookowl.CreateReadEventRequest.read_event_info', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='bookmark_id', full_name='bookowl.CreateReadEventRequest.bookmark_id', index=1,
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
  serialized_start=62,
  serialized_end=156,
)


_CREATEREADEVENTRESPONSE = _descriptor.Descriptor(
  name='CreateReadEventResponse',
  full_name='bookowl.CreateReadEventResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='read_event_id', full_name='bookowl.CreateReadEventResponse.read_event_id', index=0,
      number=1, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.CreateReadEventResponse.time', index=1,
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
  serialized_start=158,
  serialized_end=248,
)


_GETREADEVENTSBYBOOKIDREQUEST = _descriptor.Descriptor(
  name='GetReadEventsByBookIDRequest',
  full_name='bookowl.GetReadEventsByBookIDRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='book_id', full_name='bookowl.GetReadEventsByBookIDRequest.book_id', index=0,
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
  serialized_start=250,
  serialized_end=297,
)


_GETREADEVENTSRESPONSE = _descriptor.Descriptor(
  name='GetReadEventsResponse',
  full_name='bookowl.GetReadEventsResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='read_events_info', full_name='bookowl.GetReadEventsResponse.read_events_info', index=0,
      number=1, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='time', full_name='bookowl.GetReadEventsResponse.time', index=1,
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
  serialized_start=299,
  serialized_end=414,
)


_READEVENTINFO = _descriptor.Descriptor(
  name='ReadEventInfo',
  full_name='bookowl.ReadEventInfo',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='read_start_time', full_name='bookowl.ReadEventInfo.read_start_time', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='read_end_time', full_name='bookowl.ReadEventInfo.read_end_time', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='read_start_width_revel', full_name='bookowl.ReadEventInfo.read_start_width_revel', index=2,
      number=3, type=3, cpp_type=2, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='read_end_width_level', full_name='bookowl.ReadEventInfo.read_end_width_level', index=3,
      number=4, type=3, cpp_type=2, label=1,
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
  serialized_start=417,
  serialized_end=598,
)

_CREATEREADEVENTREQUEST.fields_by_name['read_event_info'].message_type = _READEVENTINFO
_CREATEREADEVENTRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_GETREADEVENTSRESPONSE.fields_by_name['read_events_info'].message_type = _READEVENTINFO
_GETREADEVENTSRESPONSE.fields_by_name['time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_READEVENTINFO.fields_by_name['read_start_time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
_READEVENTINFO.fields_by_name['read_end_time'].message_type = google_dot_protobuf_dot_timestamp__pb2._TIMESTAMP
DESCRIPTOR.message_types_by_name['CreateReadEventRequest'] = _CREATEREADEVENTREQUEST
DESCRIPTOR.message_types_by_name['CreateReadEventResponse'] = _CREATEREADEVENTRESPONSE
DESCRIPTOR.message_types_by_name['GetReadEventsByBookIDRequest'] = _GETREADEVENTSBYBOOKIDREQUEST
DESCRIPTOR.message_types_by_name['GetReadEventsResponse'] = _GETREADEVENTSRESPONSE
DESCRIPTOR.message_types_by_name['ReadEventInfo'] = _READEVENTINFO
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

CreateReadEventRequest = _reflection.GeneratedProtocolMessageType('CreateReadEventRequest', (_message.Message,), {
  'DESCRIPTOR' : _CREATEREADEVENTREQUEST,
  '__module__' : 'read_event_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.CreateReadEventRequest)
  })
_sym_db.RegisterMessage(CreateReadEventRequest)

CreateReadEventResponse = _reflection.GeneratedProtocolMessageType('CreateReadEventResponse', (_message.Message,), {
  'DESCRIPTOR' : _CREATEREADEVENTRESPONSE,
  '__module__' : 'read_event_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.CreateReadEventResponse)
  })
_sym_db.RegisterMessage(CreateReadEventResponse)

GetReadEventsByBookIDRequest = _reflection.GeneratedProtocolMessageType('GetReadEventsByBookIDRequest', (_message.Message,), {
  'DESCRIPTOR' : _GETREADEVENTSBYBOOKIDREQUEST,
  '__module__' : 'read_event_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetReadEventsByBookIDRequest)
  })
_sym_db.RegisterMessage(GetReadEventsByBookIDRequest)

GetReadEventsResponse = _reflection.GeneratedProtocolMessageType('GetReadEventsResponse', (_message.Message,), {
  'DESCRIPTOR' : _GETREADEVENTSRESPONSE,
  '__module__' : 'read_event_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.GetReadEventsResponse)
  })
_sym_db.RegisterMessage(GetReadEventsResponse)

ReadEventInfo = _reflection.GeneratedProtocolMessageType('ReadEventInfo', (_message.Message,), {
  'DESCRIPTOR' : _READEVENTINFO,
  '__module__' : 'read_event_pb2'
  # @@protoc_insertion_point(class_scope:bookowl.ReadEventInfo)
  })
_sym_db.RegisterMessage(ReadEventInfo)


DESCRIPTOR._options = None

_READEVENT = _descriptor.ServiceDescriptor(
  name='ReadEvent',
  full_name='bookowl.ReadEvent',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=601,
  serialized_end=794,
  methods=[
  _descriptor.MethodDescriptor(
    name='CreateReadEvent',
    full_name='bookowl.ReadEvent.CreateReadEvent',
    index=0,
    containing_service=None,
    input_type=_CREATEREADEVENTREQUEST,
    output_type=_CREATEREADEVENTRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetReadEventsByBookID',
    full_name='bookowl.ReadEvent.GetReadEventsByBookID',
    index=1,
    containing_service=None,
    input_type=_GETREADEVENTSBYBOOKIDREQUEST,
    output_type=_GETREADEVENTSRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_READEVENT)

DESCRIPTOR.services_by_name['ReadEvent'] = _READEVENT

# @@protoc_insertion_point(module_scope)
