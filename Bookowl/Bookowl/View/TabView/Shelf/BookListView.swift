//
//  BookListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookListView: View {
    let books : [BookModel]
    var body: some View {
        NavigationView{
            ZStack {
                Color(red: 255/255, green: 241/255, blue: 179/255)
                    .edgesIgnoringSafeArea(.all)
                List(books){
                    book in
                    NavigationLink(
                        destination: BookView(model: book)){
                        BookCell(model: book)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 150, alignment: .center)
                        }
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        let books = [BookModel(id: "1", name: "owl", status: "Unread", progress: 64, imagePath: "owl", bookMarkId: "0")]
        BookListView(books: books)
    }
}
