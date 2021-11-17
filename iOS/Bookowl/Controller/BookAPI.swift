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
    @Published var bookInfos:[Bookowl_BookInfo] = []
    @Published var unReads = BookModels()
    @Published var reading = BookModels()
    @Published var completed = BookModels()
    let port = 8080
//    var connection : ClientConnection?
//    var client : Bookowl_BookClient?

    
    init(){
        bookInfos = self.getBookByUserIdRequest()
        self.divideByStatus(bookInfos: bookInfos)
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
    
    func RegisterBookRequest(model : Bookowl_BookInfo) -> Bookowl_BookInfo! {
        print("registerAPI")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_RegisterBookRequest()
        request.userID = UInt64(USER_ID)
//        request.readStatus = .readUnread
        request.isbn = model.isbn
//        request.widthLevel = Int64(model.widthLevel)
//        print(model.widthLevel)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print(model.isbn)
                print("registered")
                let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.registerBook(request, callOptions: CallOptions()).response.wait()
                print("registerBook")
                print(response.bookInfo.isbn)
                print(response.bookInfo.authors)
                reload()
                return response.bookInfo
            }catch let error{
                print(error)
            }
        return nil
    }
    
    func UpdateBookmarkIDRequest(request : Bookowl_UpdateBookmarkIDRequest) -> Bool{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.updateBookmarkID(request, callOptions: CallOptions()).response.wait()
            print("BookMarker is Updated!!")
            reload()
            return true
        }catch let error{
            print(error)
        }
        return false
    }
    
    func UpdateReadStatusRequest(request: Bookowl_UpdateReadStatusRequest) {
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.updateReadStatus(request, callOptions: CallOptions()).response.wait()
            print("BookStatus is Updated!!")
        }catch let error{
            print(error)
        }
    }
    
 
    func getBookByUserIdRequest() -> [Bookowl_BookInfo]!{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetBooksRequest()
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.getBooks(request, callOptions: CallOptions()).response.wait()
            print("response!!")
            self.bookInfos = response.booksInfo
            return response.booksInfo
        }catch let error{
            print(error)
        }
        return nil
    }
    
    func divideByStatus(bookInfos : [Bookowl_BookInfo]){
        print("devide")
        self.unReads.clear()
        self.completed.clear()
        self.reading.clear()
        for bookInfo in bookInfos {
            let bookModel = BookModel(id: bookInfo.bookID, name: bookInfo.name, status: bookInfo.readStatus, progress: 0, imagePath: bookInfo.bookThumbnail, bookMarkId: bookInfo.bookmarkID, isbn: bookInfo.isbn, widthLevel: 0, authors: bookInfo.authors, price: bookInfo.price, pages: bookInfo.pages)
            
            switch bookInfo.readStatus{
            case .readComplete:
                self.completed.append(book:bookModel)
                break
            case .readUnread, .readSuspended, .readUnspecified:
                self.unReads.append(book: bookModel)
                break
            case .readReading:
                self.reading.append(book: bookModel)
                
                break
            default: break
            }
        }
    }
    
    func reload(){
        bookInfos = self.getBookByUserIdRequest()
        self.divideByStatus(bookInfos: bookInfos)
    }
    
    func getBooks(status:Bookowl_ReadStatus)-> [BookModel]{
        if status == .readReading{
            return reading.books
        }else if status == .readUnread || status == .readSuspended{
            return unReads.books
        }else {
            return completed.books
        }
    }
    
}
