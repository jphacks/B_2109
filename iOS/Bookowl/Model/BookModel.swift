//
//  BookModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftUI

class BookModel : ObservableObject, Identifiable{

    init(id:UInt64, name : String, status : Bookowl_ReadStatus, progress : UInt64, imagePath : String, bookMarkId : UInt64, isbn:String, widthLevel : UInt64, authors : [String], price:Int64, pages : Int64){
        self.bookId = id
        self.name = name
        self.status = status
        self.pages = pages
        self.progress = progress
        self.imagePath = imagePath
        self.widthLevel  = widthLevel
        self.authors = authors
        self.price = price
        self.bookMarkId = bookMarkId
        self.isbn = isbn
    }
    var bookId : UInt64 = 0
    var name : String = ""
    @Published var status : Bookowl_ReadStatus = .readUnread
    var progress : UInt64 = 0
    var imagePath : String = ""
    var bookMarkId : UInt64 = 0
    var isbn : String = ""
    var widthLevel : UInt64 = 0
    var authors : [String] = [""]
    var price : Int64  = 0
    var pages : Int64 = 0 
}

