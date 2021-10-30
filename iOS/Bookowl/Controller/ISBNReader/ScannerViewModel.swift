//
//  ScannerViewModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import Foundation

class ScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0
    @Published var lastQrCode: String = "QRコード"
    @Published var isShowing: Bool = false
    @Published var isLoading: Bool = false
    private var bookRegisterAPI = BookAPI(viewName: "scanner")
    var bookModel = INIT_BOOK_MODEL
    func onFoundQrCode(_ code: String) {
        print(code)
        self.lastQrCode = code
        isShowing = true
        bookModel.isbn = lastQrCode
        
        let bookInfo =  self.bookRegisterAPI.RegisterBookRequest(model: self.bookModel)
        if bookInfo == nil{
            print("nil!!!!")
        }else{
            print(bookInfo!.pages)
            print(bookInfo!.authors)
            print(bookInfo!)
            self.bookModel.id = bookInfo!.bookID
            self.bookModel.name = bookInfo!.name
            self.bookModel.imagePath = bookInfo!.bookThumbnail
            self.bookModel.authors = bookInfo!.authors
            self.bookModel.price = bookInfo!.price
            self.bookModel.pages = bookInfo!.pages
            DispatchQueue.main.async{
                self.isLoading = true
                self.isShowing = false
            print("finish")
            }
        }
        
    }
}
