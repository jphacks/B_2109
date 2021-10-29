# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import goal_pb2 as goal__pb2


class GoalStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.CreateGoal = channel.unary_unary(
                '/bookowl.Goal/CreateGoal',
                request_serializer=goal__pb2.CreateGoalRequest.SerializeToString,
                response_deserializer=goal__pb2.CreateGoalResponse.FromString,
                )
        self.GetByUserID = channel.unary_unary(
                '/bookowl.Goal/GetByUserID',
                request_serializer=goal__pb2.GetGoalByUserIDRequest.SerializeToString,
                response_deserializer=goal__pb2.GetGoalsResponse.FromString,
                )
        self.UpdateGoalStatus = channel.unary_unary(
                '/bookowl.Goal/UpdateGoalStatus',
                request_serializer=goal__pb2.UpdateGoalStatusRequest.SerializeToString,
                response_deserializer=goal__pb2.UpdateGoalResponse.FromString,
                )


class GoalServicer(object):
    """Missing associated documentation comment in .proto file."""

    def CreateGoal(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetByUserID(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def UpdateGoalStatus(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_GoalServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'CreateGoal': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateGoal,
                    request_deserializer=goal__pb2.CreateGoalRequest.FromString,
                    response_serializer=goal__pb2.CreateGoalResponse.SerializeToString,
            ),
            'GetByUserID': grpc.unary_unary_rpc_method_handler(
                    servicer.GetByUserID,
                    request_deserializer=goal__pb2.GetGoalByUserIDRequest.FromString,
                    response_serializer=goal__pb2.GetGoalsResponse.SerializeToString,
            ),
            'UpdateGoalStatus': grpc.unary_unary_rpc_method_handler(
                    servicer.UpdateGoalStatus,
                    request_deserializer=goal__pb2.UpdateGoalStatusRequest.FromString,
                    response_serializer=goal__pb2.UpdateGoalResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'bookowl.Goal', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Goal(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def CreateGoal(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Goal/CreateGoal',
            goal__pb2.CreateGoalRequest.SerializeToString,
            goal__pb2.CreateGoalResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetByUserID(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Goal/GetByUserID',
            goal__pb2.GetGoalByUserIDRequest.SerializeToString,
            goal__pb2.GetGoalsResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def UpdateGoalStatus(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/bookowl.Goal/UpdateGoalStatus',
            goal__pb2.UpdateGoalStatusRequest.SerializeToString,
            goal__pb2.UpdateGoalResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)