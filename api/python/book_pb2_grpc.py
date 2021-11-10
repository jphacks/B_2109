# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import book_pb2 as book__pb2


class BookStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.RegisterBook = channel.unary_unary(
                '/bookowl.Book/RegisterBook',
                request_serializer=book__pb2.RegisterBookRequest.SerializeToString,
                response_deserializer=book__pb2.RegisterBookResponse.FromString,
                )
        self.UpdateBookmarkID = channel.unary_unary(
                '/bookowl.Book/UpdateBookmarkID',
                request_serializer=book__pb2.UpdateBookmarkIDRequest.SerializeToString,
                response_deserializer=book__pb2.UpdateBookResponse.FromString,
                )
        self.UpdateReadStatus = channel.unary_unary(
                '/bookowl.Book/UpdateReadStatus',
                request_serializer=book__pb2.UpdateReadStatusRequest.SerializeToString,
                response_deserializer=book__pb2.UpdateBookResponse.FromString,
                )
        self.GetBooks = channel.unary_unary(
                '/bookowl.Book/GetBooks',
                request_serializer=book__pb2.GetBooksRequest.SerializeToString,
                response_deserializer=book__pb2.GetBooksResponse.FromString,
                )
        self.GetReadPercentage = channel.unary_unary(
                '/bookowl.Book/GetReadPercentage',
                request_serializer=book__pb2.GetReadPercentageRequest.SerializeToString,
                response_deserializer=book__pb2.GetReadPercentageResponse.FromString,
                )
        self.GetReadPages = channel.unary_unary(
                '/bookowl.Book/GetReadPages',
                request_serializer=book__pb2.GetReadPagesRequest.SerializeToString,
                response_deserializer=book__pb2.GetReadPagesResponse.FromString,
                )
        self.GetReadPagesWithDuration = channel.unary_unary(
                '/bookowl.Book/GetReadPagesWithDuration',
                request_serializer=book__pb2.GetReadPagesWithDurationRequest.SerializeToString,
                response_deserializer=book__pb2.GetReadPagesResponse.FromString,
                )
        self.GetReadPagesByBookID = channel.unary_unary(
                '/bookowl.Book/GetReadPagesByBookID',
                request_serializer=book__pb2.GetReadPagesByBookIDRequest.SerializeToString,
                response_deserializer=book__pb2.GetReadPagesResponse.FromString,
                )
        self.GetBookmarkStatus = channel.unary_unary(
                '/bookowl.Book/GetBookmarkStatus',
                request_serializer=book__pb2.GetBookmarkStatusRequest.SerializeToString,
                response_deserializer=book__pb2.GetBookmarkStatusResponse.FromString,
                )


class BookServicer(object):
    """Missing associated documentation comment in .proto file."""

    def RegisterBook(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateBookmarkID(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateReadStatus(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetBooks(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetReadPercentage(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetReadPages(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetReadPagesWithDuration(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetReadPagesByBookID(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetBookmarkStatus(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_BookServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'RegisterBook': grpc.unary_unary_rpc_method_handler(
                    servicer.RegisterBook,
                    request_deserializer=book__pb2.RegisterBookRequest.FromString,
                    response_serializer=book__pb2.RegisterBookResponse.SerializeToString,
            ),
            'UpdateBookmarkID': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateBookmarkID,
                    request_deserializer=book__pb2.UpdateBookmarkIDRequest.FromString,
                    response_serializer=book__pb2.UpdateBookResponse.SerializeToString,
            ),
            'UpdateReadStatus': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateReadStatus,
                    request_deserializer=book__pb2.UpdateReadStatusRequest.FromString,
                    response_serializer=book__pb2.UpdateBookResponse.SerializeToString,
            ),
            'GetBooks': grpc.unary_unary_rpc_method_handler(
                    servicer.GetBooks,
                    request_deserializer=book__pb2.GetBooksRequest.FromString,
                    response_serializer=book__pb2.GetBooksResponse.SerializeToString,
            ),
            'GetReadPercentage': grpc.unary_unary_rpc_method_handler(
                    servicer.GetReadPercentage,
                    request_deserializer=book__pb2.GetReadPercentageRequest.FromString,
                    response_serializer=book__pb2.GetReadPercentageResponse.SerializeToString,
            ),
            'GetReadPages': grpc.unary_unary_rpc_method_handler(
                    servicer.GetReadPages,
                    request_deserializer=book__pb2.GetReadPagesRequest.FromString,
                    response_serializer=book__pb2.GetReadPagesResponse.SerializeToString,
            ),
            'GetReadPagesWithDuration': grpc.unary_unary_rpc_method_handler(
                    servicer.GetReadPagesWithDuration,
                    request_deserializer=book__pb2.GetReadPagesWithDurationRequest.FromString,
                    response_serializer=book__pb2.GetReadPagesResponse.SerializeToString,
            ),
            'GetReadPagesByBookID': grpc.unary_unary_rpc_method_handler(
                    servicer.GetReadPagesByBookID,
                    request_deserializer=book__pb2.GetReadPagesByBookIDRequest.FromString,
                    response_serializer=book__pb2.GetReadPagesResponse.SerializeToString,
            ),
            'GetBookmarkStatus': grpc.unary_unary_rpc_method_handler(
                    servicer.GetBookmarkStatus,
                    request_deserializer=book__pb2.GetBookmarkStatusRequest.FromString,
                    response_serializer=book__pb2.GetBookmarkStatusResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'bookowl.Book', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Book(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def RegisterBook(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/RegisterBook',
            book__pb2.RegisterBookRequest.SerializeToString,
            book__pb2.RegisterBookResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def UpdateBookmarkID(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/UpdateBookmarkID',
            book__pb2.UpdateBookmarkIDRequest.SerializeToString,
            book__pb2.UpdateBookResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def UpdateReadStatus(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/UpdateReadStatus',
            book__pb2.UpdateReadStatusRequest.SerializeToString,
            book__pb2.UpdateBookResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetBooks(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetBooks',
            book__pb2.GetBooksRequest.SerializeToString,
            book__pb2.GetBooksResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetReadPercentage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetReadPercentage',
            book__pb2.GetReadPercentageRequest.SerializeToString,
            book__pb2.GetReadPercentageResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetReadPages(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetReadPages',
            book__pb2.GetReadPagesRequest.SerializeToString,
            book__pb2.GetReadPagesResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetReadPagesWithDuration(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetReadPagesWithDuration',
            book__pb2.GetReadPagesWithDurationRequest.SerializeToString,
            book__pb2.GetReadPagesResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetReadPagesByBookID(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetReadPagesByBookID',
            book__pb2.GetReadPagesByBookIDRequest.SerializeToString,
            book__pb2.GetReadPagesResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetBookmarkStatus(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Book/GetBookmarkStatus',
            book__pb2.GetBookmarkStatusRequest.SerializeToString,
            book__pb2.GetBookmarkStatusResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
