//
//  BookListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookListView: View {
    let books : [BookModel]
    let background =  Color(red: 255/255, green: 241/255, blue: 179/255)
    
    init(books:[BookModel]){
            //List全体の背景色の設定
        self.books = books
            UITableView.appearance().backgroundColor = UIColor(background)
        }
    
    var body: some View {
        NavigationView{
            ZStack {
               background
                    .edgesIgnoringSafeArea(.all)
                List(books){
                    book in
                    NavigationLink(
                        destination: BookView(model: book)){
                        BookCell(model: book)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 150, alignment: .center)
                        }
                    }
//                .position(x: 0, y: 80)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-250, alignment: .center)
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        let books = [INIT_BOOK_MODEL]
        BookListView(books: books)
    }
}
