//
//  BookModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation

struct BookModel : Hashable, Codable, Identifiable{
    var id : String
    var name : String
    var status : String
    var progress : Int
    var imagePath : String
}
