//
//  BookListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookListView: View {
    @State var books : [Bookowl_BookInfo]
    let background =  Color(red: 255/255, green: 241/255, blue: 179/255)
    
    init(books:[Bookowl_BookInfo]){
            //List全体の背景色の設定
        self.books = books
            UITableView.appearance().backgroundColor = UIColor(background)
        }
    
    var body: some View {
            ZStack {
               background
                    .edgesIgnoringSafeArea(.all)
                List{
                    ForEach(0 ..< books.count) { book in
                                    
                        ZStack{
                            NavigationLink(destination: BookView(model: $books[book])) {
                                    background.edgesIgnoringSafeArea(.all)
                                        EmptyView()
                                        .foregroundColor(background)
                                }.frame(width: 0, height: 0).opacity(0).hidden()
                            BookCell(model: books[book])
                                .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                        }
                    }
//                        .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                    }
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-250, alignment: .center)
//                .position(x: 0, y: 80)
//            }
        }
    }


//struct BookListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let books = [INIT_BOOK_MODEL]
//        BookListView(books: books)
//    }
//}
