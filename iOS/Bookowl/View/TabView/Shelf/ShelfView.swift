//
//  ShelfView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI
import SegmentedPicker
import PagerTabStripView
import SwiftUIRefresh
struct Book : Identifiable {
    var id: String
    var name: String
}
class reloadModel : ObservableObject{
    @Published var isReload = false
}
struct ShelfView: View {
//    TODO: BookModelの渡し方
    let titles = ["読書中","積読中","読了本"]
    @State var selectedIndex: Int = 0
    @State var isRegisterBook = false
    @ObservedObject var isReload = reloadModel()
    @ObservedObject var bookAPI = BookAPI()
    @ObservedObject var reading = BookModels()
    @ObservedObject var unReads = BookModels()
    @ObservedObject var completed = BookModels()
    @State var isShowing = false
        var body: some View {
            NavigationView{
            ZStack{
                backgroundColor.edgesIgnoringSafeArea(.all)
                VStack{
                    PagerTabStripView() {
                        BookListView(books: _reading,isReload: _isReload,status: Bookowl_ReadStatus.readReading).pagerTabItem {
                            TitleNavBarItem(title: "読書中")
                        }.onPageAppear {
        //                    homeModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                bookAPI.divideByStatus(bookInfos: bookAPI.bookInfos)
//                                self.reading.setBooks(books:bookAPI.getBooks(status: .readReading))
                            }
                        }

                        BookListView(books: _unReads,isReload: _isReload, status:Bookowl_ReadStatus.readUnread).pagerTabItem {
                            TitleNavBarItem(title: "積読中")
                        }
                        .onPageAppear {
        //                    trendingModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                self.unReads.setBooks(books:bookAPI.getBooks(status: .readUnread))
                            }
                        }

                        BookListView(books: _completed,isReload: _isReload, status:Bookowl_ReadStatus.readComplete).pagerTabItem {
                        TitleNavBarItem(title: "読了本")
                        } .onPageAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                                self.completed.setBooks(books:bookAPI.getBooks(status: .readComplete))
                            }
                        }

                        
                    }
                    .pagerTabStripViewStyle(.normal(indicatorBarHeight: 5, indicatorBarColor: selectedColor, tabItemHeight: 80))
                    
                    .frame(alignment: .center)

                }
            }
            .navigationBarItems(trailing: Button(action: {
                isRegisterBook = true  
            }){
                Text("本登録")
                    .fullScreenCover(isPresented: $isRegisterBook, onDismiss: {
                        isReload.isReload = true
                    }){
                        ISBNView(viewModel: ScannerViewModel() , isActive: $isRegisterBook, bookAPI: bookAPI )
                    }
            })
                .navigationTitle("本棚")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .onChange(of: isReload.isReload){
                    newValue in
                    print("registerChanged!!")
                    print(newValue)
                    if newValue == true{
                        bookAPI.reload()
                        reading.setBooks(books:bookAPI.getBooks(status: .readReading))
                        unReads.setBooks(books:bookAPI.getBooks(status: .readUnread))
                        completed.setBooks(books: bookAPI.getBooks(status: .readComplete))
                        isReload.isReload.toggle()
                    }
                }
                }
            .onAppear(perform: {
                reading.setBooks(books:bookAPI.getBooks(status: .readReading))
                unReads.setBooks(books:bookAPI.getBooks(status: .readUnread))
                completed.setBooks(books: bookAPI.getBooks(status: .readComplete))
            })
            
    }

}
    

struct RefreshControl: View {
    
    @State private var isRefreshing = false
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .named(coordinateSpaceName)).midY > 50 {
                Spacer()
                    .onAppear() {
                        isRefreshing = true
                    }
            } else if geometry.frame(in: .named(coordinateSpaceName)).maxY < 10 {
                Spacer()
                    .onAppear() {
                        if isRefreshing {
                            isRefreshing = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if isRefreshing {
                    ProgressView()
                } else {
                    Text("⬇︎")
                        .font(.system(size: 28))
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
    }
}
