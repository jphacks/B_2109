# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import read_event_pb2 as read__event__pb2


class ReadEventStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.CreateReadEvent = channel.unary_unary(
                '/bookowl.ReadEvent/CreateReadEvent',
                request_serializer=read__event__pb2.CreateReadEventRequest.SerializeToString,
                response_deserializer=read__event__pb2.CreateReadEventResponse.FromString,
                )
        self.GetReadEventsByBookID = channel.unary_unary(
                '/bookowl.ReadEvent/GetReadEventsByBookID',
                request_serializer=read__event__pb2.GetReadEventsByBookIDRequest.SerializeToString,
                response_deserializer=read__event__pb2.GetReadEventsResponse.FromString,
                )


class ReadEventServicer(object):
    """Missing associated documentation comment in .proto file."""

    def CreateReadEvent(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetReadEventsByBookID(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_ReadEventServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'CreateReadEvent': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateReadEvent,
                    request_deserializer=read__event__pb2.CreateReadEventRequest.FromString,
                    response_serializer=read__event__pb2.CreateReadEventResponse.SerializeToString,
            ),
            'GetReadEventsByBookID': grpc.unary_unary_rpc_method_handler(
                    servicer.GetReadEventsByBookID,
                    request_deserializer=read__event__pb2.GetReadEventsByBookIDRequest.FromString,
                    response_serializer=read__event__pb2.GetReadEventsResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'bookowl.ReadEvent', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class ReadEvent(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def CreateReadEvent(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.ReadEvent/CreateReadEvent',
            read__event__pb2.CreateReadEventRequest.SerializeToString,
            read__event__pb2.CreateReadEventResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetReadEventsByBookID(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.ReadEvent/GetReadEventsByBookID',
            read__event__pb2.GetReadEventsByBookIDRequest.SerializeToString,
            read__event__pb2.GetReadEventsResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
