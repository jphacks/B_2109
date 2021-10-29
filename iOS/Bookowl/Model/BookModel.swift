//
//  BookModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation

struct BookModel : Hashable,  Identifiable{
    var id : UInt64
    var name : String
    var status : Bookowl_ReadStatus
    var progress : UInt64
    var imagePath : String
    var bookMarkId : UInt64
    var isbn : String
    var widthLevel : UInt64
    var authors : [String]
    var price : Int64
    var pages : Int64
}

