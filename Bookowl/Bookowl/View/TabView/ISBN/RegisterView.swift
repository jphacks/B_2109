//
//  RegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct RegisterView: View {
    var isbn : String
    var bookInfo : BookModel
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    var body: some View {
        VStack{
        
            HStack{
                Text("a")
            }
        }
        }
    }



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let isbn = ""
        let bookModel = BookModel(id: "0", name: "a", status: "2", progress: 53, imagePath: "0", bookMarkId: "0")
        RegisterView(isbn: isbn, bookInfo: bookModel )
    }
}

