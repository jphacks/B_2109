//
//  Const.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/30.
//

import Foundation
import SwiftUI
let USER_ID = 1
let backgroundColor = Color(red: 255/255, green: 241/255, blue: 179/255)
let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
let green = Color(red: 143/255, green: 156/255, blue: 64/255)
let orange = Color(red: 250/255, green: 187/255, blue: 118/255)
let red = Color(red: 169/255, green: 49/255, blue: 48/255)
let INIT_BOOK_MODEL = BookModel.init(id: UInt64(USER_ID), name: "owl", status: .readUnread, progress: 0, imagePath: "", bookMarkId: 0, isbn: "", widthLevel: 0,authors: [""], price: 0, pages: 0)

let ReadModels = [BookModel(id: UInt64(USER_ID), name: "初めてのSpark", status: .readReading, progress: 20, imagePath: "1", bookMarkId: 2, isbn: "", widthLevel: 300,authors: ["Holden Karau、Andy Konwinski、Patrick Wendell、Matei Zaharia"], price: 3520, pages: 290),
BookModel(id: UInt64(USER_ID), name: "入門 ソーシャルデータ――データマイニング、分析、可視化のテクニック", status: .readReading, progress: 40, imagePath: "2", bookMarkId: 3, isbn: "", widthLevel: 450,authors: ["Matthew A. Russel"], price: 3960, pages: 430),
                  BookModel(id: UInt64(USER_ID), name: "データ分析によるネットワークセキュリティ", status: .readReading, progress: 60, imagePath: "3", bookMarkId: 4, isbn: "", widthLevel: 360,authors: ["Michael Collins"], price: 3960, pages: 350)]

let unReadModels = [
    BookModel(id: UInt64(USER_ID), name: "独習アセンブラ 新版", status: .readUnread, progress: 0, imagePath: "4", bookMarkId: 0, isbn: "", widthLevel: 800,authors: ["大崎博之"], price: 4268, pages: 700)]
let completedModels = [
BookModel(id: UInt64(USER_ID), name: "Hadoop 第3版", status: .readComplete, progress: 100, imagePath: "5", bookMarkId: 0, isbn: "", widthLevel: 800,authors: ["Tom White"], price: 4268, pages: 700),
BookModel(id: UInt64(USER_ID), name: "実践Rustプログラミング入門", status: .readUnread, progress: 0, imagePath: "6", bookMarkId: 0, isbn: "", widthLevel: 800,authors: ["初田　直也,山口　聖弘,豊田　優貴,松本　健太郎,原　将己,中村　謙弘"], price: 4268, pages: 700)]
