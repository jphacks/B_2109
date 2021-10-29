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
            backgroundColor
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
        BookCell(model: INIT_BOOK_MODEL)
    }
}
