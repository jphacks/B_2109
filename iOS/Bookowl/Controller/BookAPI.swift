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
    @Published var bookInfos:[BookModel] = []
    @Published var unReads = BookModels()
    @Published var reading = BookModels()
    @Published var completed = BookModels()
    let port = 8080
//    var connection : ClientConnection?
//    var client : Bookowl_BookClient?

    
    init(){
        bookInfos = self.getBookByUserIdRequest()
        self.divideByStatus(bookInfos: bookInfos)
        print("initBookAPI")
    }
    
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
//                bookInfos.append()
//                reload()
                return response.bookInfo
            }catch let error{
                print(error)
            }
        return nil
    }
    
    func UpdateBookmarkIDRequest(request : Bookowl_UpdateBookmarkIDRequest) -> Bool{
        print("updateBookmarkIDRequest")
        print(request.bookID)
        print(request.bookmarkID)
        print(request.bookWidth)
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
            print(response.bookInfo.bookmarkID)
            setBookMarkId(bookId: request.bookID, bookMarkId: request.bookmarkID, width: request.bookWidth)
//            reload()
            return true
        }catch let error{
            print("updateError!")
            print(error)
        }
        return false
    }
    
    func setBookMarkId(bookId:UInt64, bookMarkId:UInt64,width:UInt64){
        for model in bookInfos{
            if model.bookId == bookId{
                model.widthLevel = width
                model.bookMarkId = bookMarkId
            }
        }
    }
    
    func setProgressByBook(bookId:UInt64, pages:UInt64){
        for model in bookInfos{
            if model.bookId == bookId{
                let progress = pages * 100 / model.widthLevel
                model.progress = progress
            }
        }
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
//
//    func moveBookList(bookId:UInt64,status:Bookowl_ReadStatus,isFirst:Bool){
//        if isFirst{
//            switch status{
//            case .readReading:
//                reading.append()
//            }
//        }
//    }
     
 
    func getBookByUserIdRequest() -> [BookModel]!{
        let start = Date()
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
            print("getUserbyRequest!!")
            let elapsed = Date().timeIntervalSince(start)
            print(elapsed)
            let bookArray = response.booksInfo
            var bookInfos : [BookModel] = []
            for bookInfo in bookArray {
                let bookModel = BookModel(id: bookInfo.bookID, name: bookInfo.name, status: bookInfo.readStatus, progress: 0, imagePath: bookInfo.bookThumbnail, bookMarkId: bookInfo.bookmarkID, isbn: bookInfo.isbn, widthLevel: 0, authors: bookInfo.authors, price: bookInfo.price, pages: bookInfo.pages)
                
                bookInfos.append(bookModel)
            }
            return bookInfos
        }catch let error{
            print(error)
        }
        return nil
    }
    
    func divideByStatus(bookInfos : [BookModel]){
        print("divide")
        self.unReads.clear()
        self.completed.clear()
        self.reading.clear()
        for bookModel in bookInfos {
            let pages =  getReadPages(model: bookModel)
            bookModel.progress = UInt64(Int(pages * 100) / Int(bookModel.pages))
            switch bookModel.status{
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
        print("reload")
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
    
    func getReadPages(model : BookModel)-> UInt64{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetReadPagesByBookIDRequest()
        request.userID = UInt64(USER_ID)
        request.bookID = model.bookId
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do{
            let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
            let response = try client.getReadPagesByBookID(request, callOptions: CallOptions()).response.wait()
            
            print("readPages")
            print(response.readPages)
            return response.readPages
        }catch let error{
            print(error)
        }
        return 0
    }
    
}
