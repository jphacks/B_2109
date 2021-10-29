//
//  ShelfView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI
import SegmentedPicker
import PagerTabStripView
struct Book : Identifiable {
    var id: String
    var name: String
}
struct ShelfView: View {
//    TODO: BookModelの渡し方
    let titles = ["読書中","積読中","読了本"]
    @State var selectedIndex: Int = 0
    let background = Color(red: 255/255, green: 241/255, blue: 179/255)
    
        var body: some View {
            ZStack{
                background.edgesIgnoringSafeArea(.all)
                    PagerTabStripView() {
                        BookListView(books: [BookModel(id: "1", name: "owl", status: "Unread", progress: 64, imagePath: "owl", bookMarkId: "0")]).pagerTabItem {
                            TitleNavBarItem(title: "読書中")
                        }.onPageAppear {
        //                    homeModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                        homeModel.isLoading = false
                            }
                        }
                        
                        BookListView(books: [BookModel(id: "1", name: "owl", status: "Unread", progress: 64, imagePath: "owl", bookMarkId: "0")]).pagerTabItem {
                            TitleNavBarItem(title: "積読中")
                        }
                        .onPageAppear {
        //                    trendingModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                        trendingModel.isLoading = false
                            }
                        }
                        
                       BookListView(books: [BookModel(id: "1", name: "owl", status: "Unread", progress: 64, imagePath: "owl",bookMarkId: "0")]).pagerTabItem {
                        TitleNavBarItem(title: "読了本")
                        }
                            
                        
                    }
                    .pagerTabStripViewStyle(.normal(indicatorBarHeight: 5, indicatorBarColor: selectedColor, tabItemHeight: 80))
                    
                    .frame(alignment: .center)
        
            }
    }

}
          

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
    }
}