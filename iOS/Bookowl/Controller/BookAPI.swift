//
//  BookAPI.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/30.
//

import Foundation
import GRPC
import Logging
import NIO

class BookAPI : NSObject, ObservableObject{
   
//    var connection : ClientConnection?
//    var client : Bookowl_BookClient?
    override init() {
        super.init()
    }
    
//    func sendRegisterGoalrequest(model : GoalModel){
//        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
//        let connection = ClientConnection
//            .secure(group: group)
//            .connect(host: "163.221.29.71", port: 8080)
////        let client = Bookowl_GoalClient.init(channel:connection )
//        var request = Bookowl_CreateGoalRequest()
//
//        request.goalInfo.goalStatus = .goalDoing
//        request.goalInfo.startDate = model.startDate
//        request.goalInfo.endDate = model.endDate
//        request.goalInfo.numPages = Int64(model.num_pages)
//        request.goalInfo.timeAmountMinutes = Int64(model.time_amount_minutes)
//        request.goalInfo.userID = 1
//        print("aaa")
//        do {
//            let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
//            let call = client.createGoal(request, callOptions: CallOptions())
//            let response = try call.response.wait()
//            print("response!!!")
//            print(response.goalID)
//        } catch {
//            print("error!!!!")
//            print(error)
//        }
//
//    }
    
    func RegisterBookRequest(model : BookModel) -> Bookowl_BookInfo! {
        print("registerAPI")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_RegisterBookRequest()
        request.userID = UInt64(USER_ID)
        request.bookInfo.readStatus = .readUnread
        request.bookInfo.isbn = model.isbn
        request.bookInfo.widthLevel = Int64(model.widthLevel)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: "163.221.29.71", port: 8080)
            do {
                print("aaa")
                let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.registerBook(request, callOptions: CallOptions()).response.wait()
                print("registerBook")
                print(response.bookInfo.isbn)
                print(response.bookInfo.authors)
                return response.bookInfo
            }catch let error{
                print(error)
            }
        return nil
    }
    
    func UpdateBookmarkIDRequest(model : BookModel) -> Bool{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_UpdateBookmarkIDRequest()
        request.bookID = model.id
        request.bookmarkID = model.bookMarkId
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: "163.221.29.71", port: 8080)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.updateBookmarkID(request, callOptions: CallOptions()).response.wait()
            print("BookMarker is Updated!!")
            return true
        }catch let error{
            print(error)
        }
        return false
    }
    
}
