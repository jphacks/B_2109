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
    let titles = ["読書中","積読中","読了本"]
        @State var selectedIndex: Int = 0
        var body: some View {
            
            PagerTabStripView() {
                BookView().pagerTabItem {
                    TitleNavBarItem(title: "Home")
                }.onPageAppear {
//                    homeModel.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        homeModel.isLoading = false
                    }
                }
                
                BookView().pagerTabItem {
                    TitleNavBarItem(title: "Trending")
                }
                .onPageAppear {
//                    trendingModel.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        trendingModel.isLoading = false
                    }
                }
                
               BookView().pagerTabItem {
                TitleNavBarItem(title: "Account")
                }
            }
            .pagerTabStripViewStyle(.normal(indicatorBarHeight: 5, indicatorBarColor: selectedColor, tabItemHeight: 80))
            .frame(alignment: .center)
            
        }
}
          

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
    }
}
