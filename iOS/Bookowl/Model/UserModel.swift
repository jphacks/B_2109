//
//  BookModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftUI

class UserModel : Identifiable{
    var userId : UInt64 = 0
    var name = ""
    var numPages : UInt64 = 0
    var rank : UInt64 = 0
    init (userId : UInt64, name : String, numPages : UInt64, rank: UInt64){
        self.userId = userId
        self.name = name
        self.numPages = numPages
        self.rank = rank
    }
    
}

