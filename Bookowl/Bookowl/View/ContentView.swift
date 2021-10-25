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
        TabView{
            TopView()
                .tabItem {
                    VStack{
                       Text("Top")
                    }
                }.tag(1)
        
            ShelfView()
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
