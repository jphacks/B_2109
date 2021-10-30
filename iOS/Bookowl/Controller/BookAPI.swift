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

class BookAPI :  ObservableObject{
    @Published var bookInfos : [Bookowl_BookInfo] = []
    @Published var unReads : [Bookowl_BookInfo] = []
    @Published var reading : [Bookowl_BookInfo] = []
    @Published var completed : [Bookowl_BookInfo] = []
//    var connection : ClientConnection?
//    var client : Bookowl_BookClient?

    
    init(viewName : String){
        switch viewName{
        case "shelf":
            let bookinfos = self.getBookByUserIdRequest()
            self.divideByStatus(bookInfos: bookInfos)
            break
        default:break
        }
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
 
    func getBookByUserIdRequest() -> [Bookowl_BookInfo]!{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetBooksByUserIDRequest()
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: "163.221.29.71", port: 8080)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.getBooksByUserID(request, callOptions: CallOptions()).response.wait()
            print("response!!")
            self.bookInfos = response.booksInfo
            return response.booksInfo
        }catch let error{
            print(error)
        }
        return nil
    }
    
    func divideByStatus(bookInfos : [Bookowl_BookInfo]){
        print("aaa")
        for bookInfo in bookInfos {
            switch bookInfo.readStatus{
            case .readComplete:
                self.completed.append(bookInfo)
                break
            case .readUnread, .readSuspended, .readUnspecified:
                self.unReads.append( bookInfo)
                break
            case .readReading:
                self.reading.append( bookInfo)
                break
            default: break
            }
        }
    }
    
}
