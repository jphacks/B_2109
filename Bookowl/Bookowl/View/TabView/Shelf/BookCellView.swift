//
//  BookCellView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/28.
//

import Foundation
import SwiftUI
struct BookCell : View {
    
    let model : BookModel
    
    var body : some View{
        ZStack{
            Color(red: 255/255, green: 241/255, blue: 179/255)
                .edgesIgnoringSafeArea(.all)
        HStack {
            Image(model.imagePath)
                .resizable()
                .frame(width: 100, height: 150)
            Text(model.name)

            Spacer()
                }
        }
    }
}

struct BookCell_Preview :  PreviewProvider {
    static var previews: some View {
        BookCell(model: BookModel(id: "1", name: "owl", status: "Unread", progress: "64", imagePath: "owl"))
    }
}
