//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: book.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Bookowl_BookClient`, then call methods of this protocol to make API calls.
internal protocol Bookowl_BookClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Bookowl_BookClientInterceptorFactoryProtocol? { get }

  func registerBook(
    _ request: Bookowl_RegisterBookRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_RegisterBookRequest, Bookowl_RegisterBookResponse>

  func getBooksByUserID(
    _ request: Bookowl_GetBooksByUserIDRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_GetBooksByUserIDRequest, Bookowl_GetBooksResponse>

  func getBooksByBookmarkID(
    _ request: Bookowl_GetBooksByBookmarkIDRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_GetBooksByBookmarkIDRequest, Bookowl_GetBooksResponse>

  func updateBookmarkID(
    _ request: Bookowl_UpdateBookmarkIDRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_UpdateBookmarkIDRequest, Bookowl_UpdateBookResponse>

  func updateReadStatus(
    _ request: Bookowl_UpdateReadStatusRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_UpdateReadStatusRequest, Bookowl_UpdateBookResponse>

  func getProgressByUserID(
    _ request: Bookowl_GetProgressByUserIDRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_GetProgressByUserIDRequest, Bookowl_GetProgressByUserIDResponse>

  func getReadAmountPagesByUserIDWithDuration(
    _ request: Bookowl_GetReadAmountPagesByUserIDWithDurationRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Bookowl_GetReadAmountPagesByUserIDWithDurationRequest, Bookowl_GetReadAmountPagesByUserIDWithDurationResponse>
}

extension Bookowl_BookClientProtocol {
  internal var serviceName: String {
    return "bookowl.Book"
  }

  /// Registering Book
  ///
  /// - Parameters:
  ///   - request: Request to send to RegisterBook.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func registerBook(
    _ request: Bookowl_RegisterBookRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_RegisterBookRequest, Bookowl_RegisterBookResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/RegisterBook",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRegisterBookInterceptors() ?? []
    )
  }

  /// Unary call to GetBooksByUserID
  ///
  /// - Parameters:
  ///   - request: Request to send to GetBooksByUserID.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getBooksByUserID(
    _ request: Bookowl_GetBooksByUserIDRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_GetBooksByUserIDRequest, Bookowl_GetBooksResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/GetBooksByUserID",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetBooksByUserIDInterceptors() ?? []
    )
  }

  /// Unary call to GetBooksByBookmarkID
  ///
  /// - Parameters:
  ///   - request: Request to send to GetBooksByBookmarkID.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getBooksByBookmarkID(
    _ request: Bookowl_GetBooksByBookmarkIDRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_GetBooksByBookmarkIDRequest, Bookowl_GetBooksResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/GetBooksByBookmarkID",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetBooksByBookmarkIDInterceptors() ?? []
    )
  }

  /// Unary call to UpdateBookmarkID
  ///
  /// - Parameters:
  ///   - request: Request to send to UpdateBookmarkID.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func updateBookmarkID(
    _ request: Bookowl_UpdateBookmarkIDRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_UpdateBookmarkIDRequest, Bookowl_UpdateBookResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/UpdateBookmarkID",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUpdateBookmarkIDInterceptors() ?? []
    )
  }

  /// Unary call to UpdateReadStatus
  ///
  /// - Parameters:
  ///   - request: Request to send to UpdateReadStatus.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func updateReadStatus(
    _ request: Bookowl_UpdateReadStatusRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_UpdateReadStatusRequest, Bookowl_UpdateBookResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/UpdateReadStatus",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUpdateReadStatusInterceptors() ?? []
    )
  }

  /// Unary call to GetProgressByUserID
  ///
  /// - Parameters:
  ///   - request: Request to send to GetProgressByUserID.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getProgressByUserID(
    _ request: Bookowl_GetProgressByUserIDRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_GetProgressByUserIDRequest, Bookowl_GetProgressByUserIDResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/GetProgressByUserID",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetProgressByUserIDInterceptors() ?? []
    )
  }

  /// Unary call to GetReadAmountPagesByUserIDWithDuration
  ///
  /// - Parameters:
  ///   - request: Request to send to GetReadAmountPagesByUserIDWithDuration.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getReadAmountPagesByUserIDWithDuration(
    _ request: Bookowl_GetReadAmountPagesByUserIDWithDurationRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Bookowl_GetReadAmountPagesByUserIDWithDurationRequest, Bookowl_GetReadAmountPagesByUserIDWithDurationResponse> {
    return self.makeUnaryCall(
      path: "/bookowl.Book/GetReadAmountPagesByUserIDWithDuration",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetReadAmountPagesByUserIDWithDurationInterceptors() ?? []
    )
  }
}

internal protocol Bookowl_BookClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'registerBook'.
  func makeRegisterBookInterceptors() -> [ClientInterceptor<Bookowl_RegisterBookRequest, Bookowl_RegisterBookResponse>]

  /// - Returns: Interceptors to use when invoking 'getBooksByUserID'.
  func makeGetBooksByUserIDInterceptors() -> [ClientInterceptor<Bookowl_GetBooksByUserIDRequest, Bookowl_GetBooksResponse>]

  /// - Returns: Interceptors to use when invoking 'getBooksByBookmarkID'.
  func makeGetBooksByBookmarkIDInterceptors() -> [ClientInterceptor<Bookowl_GetBooksByBookmarkIDRequest, Bookowl_GetBooksResponse>]

  /// - Returns: Interceptors to use when invoking 'updateBookmarkID'.
  func makeUpdateBookmarkIDInterceptors() -> [ClientInterceptor<Bookowl_UpdateBookmarkIDRequest, Bookowl_UpdateBookResponse>]

  /// - Returns: Interceptors to use when invoking 'updateReadStatus'.
  func makeUpdateReadStatusInterceptors() -> [ClientInterceptor<Bookowl_UpdateReadStatusRequest, Bookowl_UpdateBookResponse>]

  /// - Returns: Interceptors to use when invoking 'getProgressByUserID'.
  func makeGetProgressByUserIDInterceptors() -> [ClientInterceptor<Bookowl_GetProgressByUserIDRequest, Bookowl_GetProgressByUserIDResponse>]

  /// - Returns: Interceptors to use when invoking 'getReadAmountPagesByUserIDWithDuration'.
  func makeGetReadAmountPagesByUserIDWithDurationInterceptors() -> [ClientInterceptor<Bookowl_GetReadAmountPagesByUserIDWithDurationRequest, Bookowl_GetReadAmountPagesByUserIDWithDurationResponse>]
}

internal final class Bookowl_BookClient: Bookowl_BookClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Bookowl_BookClientInterceptorFactoryProtocol?

  /// Creates a client for the bookowl.Book service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Bookowl_BookClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Bookowl_BookProvider: CallHandlerProvider {
  var interceptors: Bookowl_BookServerInterceptorFactoryProtocol? { get }

  /// Registering Book
  func registerBook(request: Bookowl_RegisterBookRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_RegisterBookResponse>

  func getBooksByUserID(request: Bookowl_GetBooksByUserIDRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_GetBooksResponse>

  func getBooksByBookmarkID(request: Bookowl_GetBooksByBookmarkIDRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_GetBooksResponse>

  func updateBookmarkID(request: Bookowl_UpdateBookmarkIDRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_UpdateBookResponse>

  func updateReadStatus(request: Bookowl_UpdateReadStatusRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_UpdateBookResponse>

  func getProgressByUserID(request: Bookowl_GetProgressByUserIDRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_GetProgressByUserIDResponse>

  func getReadAmountPagesByUserIDWithDuration(request: Bookowl_GetReadAmountPagesByUserIDWithDurationRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Bookowl_GetReadAmountPagesByUserIDWithDurationResponse>
}

extension Bookowl_BookProvider {
  internal var serviceName: Substring { return "bookowl.Book" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "RegisterBook":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_RegisterBookRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_RegisterBookResponse>(),
        interceptors: self.interceptors?.makeRegisterBookInterceptors() ?? [],
        userFunction: self.registerBook(request:context:)
      )

    case "GetBooksByUserID":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_GetBooksByUserIDRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_GetBooksResponse>(),
        interceptors: self.interceptors?.makeGetBooksByUserIDInterceptors() ?? [],
        userFunction: self.getBooksByUserID(request:context:)
      )

    case "GetBooksByBookmarkID":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_GetBooksByBookmarkIDRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_GetBooksResponse>(),
        interceptors: self.interceptors?.makeGetBooksByBookmarkIDInterceptors() ?? [],
        userFunction: self.getBooksByBookmarkID(request:context:)
      )

    case "UpdateBookmarkID":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_UpdateBookmarkIDRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_UpdateBookResponse>(),
        interceptors: self.interceptors?.makeUpdateBookmarkIDInterceptors() ?? [],
        userFunction: self.updateBookmarkID(request:context:)
      )

    case "UpdateReadStatus":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_UpdateReadStatusRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_UpdateBookResponse>(),
        interceptors: self.interceptors?.makeUpdateReadStatusInterceptors() ?? [],
        userFunction: self.updateReadStatus(request:context:)
      )

    case "GetProgressByUserID":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_GetProgressByUserIDRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_GetProgressByUserIDResponse>(),
        interceptors: self.interceptors?.makeGetProgressByUserIDInterceptors() ?? [],
        userFunction: self.getProgressByUserID(request:context:)
      )

    case "GetReadAmountPagesByUserIDWithDuration":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Bookowl_GetReadAmountPagesByUserIDWithDurationRequest>(),
        responseSerializer: ProtobufSerializer<Bookowl_GetReadAmountPagesByUserIDWithDurationResponse>(),
        interceptors: self.interceptors?.makeGetReadAmountPagesByUserIDWithDurationInterceptors() ?? [],
        userFunction: self.getReadAmountPagesByUserIDWithDuration(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Bookowl_BookServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'registerBook'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRegisterBookInterceptors() -> [ServerInterceptor<Bookowl_RegisterBookRequest, Bookowl_RegisterBookResponse>]

  /// - Returns: Interceptors to use when handling 'getBooksByUserID'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetBooksByUserIDInterceptors() -> [ServerInterceptor<Bookowl_GetBooksByUserIDRequest, Bookowl_GetBooksResponse>]

  /// - Returns: Interceptors to use when handling 'getBooksByBookmarkID'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetBooksByBookmarkIDInterceptors() -> [ServerInterceptor<Bookowl_GetBooksByBookmarkIDRequest, Bookowl_GetBooksResponse>]

  /// - Returns: Interceptors to use when handling 'updateBookmarkID'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUpdateBookmarkIDInterceptors() -> [ServerInterceptor<Bookowl_UpdateBookmarkIDRequest, Bookowl_UpdateBookResponse>]

  /// - Returns: Interceptors to use when handling 'updateReadStatus'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUpdateReadStatusInterceptors() -> [ServerInterceptor<Bookowl_UpdateReadStatusRequest, Bookowl_UpdateBookResponse>]

  /// - Returns: Interceptors to use when handling 'getProgressByUserID'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetProgressByUserIDInterceptors() -> [ServerInterceptor<Bookowl_GetProgressByUserIDRequest, Bookowl_GetProgressByUserIDResponse>]

  /// - Returns: Interceptors to use when handling 'getReadAmountPagesByUserIDWithDuration'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetReadAmountPagesByUserIDWithDurationInterceptors() -> [ServerInterceptor<Bookowl_GetReadAmountPagesByUserIDWithDurationRequest, Bookowl_GetReadAmountPagesByUserIDWithDurationResponse>]
}
