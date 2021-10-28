//
//  ContentView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import SwiftUI
struct ContentView: View {
    let scannerModel = ScannerViewModel()
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 241/255, blue: 179/255)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                TabView{
                    TopView()
                        // タイトルと左右のアイコンを指定
                .tabItem {
                    VStack{
                       Text("Top")
                    }
                }.tag(1)
        
                ShelfView()
                    // タイトルと左右のアイコンを指定
                .tabItem{
                    VStack{
                        Text("Shelf")
                    }
                }.tag(2)
            
            ISBNView(viewModel:scannerModel)
                .tabItem{
                    VStack{
                        Text("BarCode")
                    }
                }.tag(3)
        }
                .navigationBarTitle("ブックロウ", displayMode: .inline)
            }.navigationViewStyle(StackNavigationViewStyle())
    }
}
}

// Iconの形式をそろえる
struct IconView: View {
    var systemName: String
    var body: some View {
        Image(systemName)
            .resizable()
            .font(.title)
            .frame(width: 50, height: 50, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
