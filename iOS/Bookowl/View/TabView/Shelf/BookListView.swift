//
//  BookListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI
import SwiftUIRefresh
import CoreAudio
class BookModels : ObservableObject{
    @Published var books : [BookModel] = []
    func setBooks(books:[BookModel]){
        self.books = books
    }
    func append(book : BookModel){
        self.books.append(book)
    }
    func clear(){
        books = []
    }
}
struct BookListView: View {
    @ObservedObject var books : BookModels
    @ObservedObject var isReload : reloadModel
    let background =  Color(red: 255/255, green: 241/255, blue: 179/255)
    var status = Bookowl_ReadStatus.readUnread
    init(books:ObservedObject<BookModels>,isReload:ObservedObject<reloadModel>, status:Bookowl_ReadStatus){
        //List全体の背景色の設定
        UITableView.appearance().backgroundColor = UIColor(background)
//        self._bookAPI = bookAPI
        self._books = books
        self._isReload = isReload
        self.status = status
    }
    
    var body: some View {
            ZStack {
               background
                    .edgesIgnoringSafeArea(.all)
                List{
                    ForEach(books.books, id:\.bookId) { book in
                                NavigationLink(destination: BookView(model: book, isReload: isReload)) {
                                            background.edgesIgnoringSafeArea(.all)
//                                                EmptyView()
//                                                .foregroundColor(background)
                                    BookCell(model: book)
                                        .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                                        .listRowBackground(backgroundColor)
                                }
                    }
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
extension Binding where Value: RandomAccessCollection & MutableCollection, Value.Element: Identifiable {
    struct IdentifiableItem: Identifiable {
        @Binding<Value.Element> private(set) var item: Value.Element
        let index: Value.Index
        let id: Value.Element.ID
    }

    var identifiableItems: [IdentifiableItem] {
        return self.wrappedValue.indices.map { i in
            return .init(
                item: .init {
                    self.wrappedValue[i]
                } set: {newValue in
                    self.wrappedValue[i] = newValue
                },
                index: i,
                id: self.wrappedValue[i].id
            )
        }
    }
}
