//
//  BookCellView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/28.
//

import Foundation
import SwiftUI
struct BookCell : View {
    
    var model : BookModel
    
    var body : some View{
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
        HStack {
            URLImageView(viewModel: .init(url: model.imagePath))
                .frame(width: 100, height: 150)
                .padding(10)
//            VStack{
            Text(model.name)
                .padding(10)
//            if model.authors.count > 1{
//                Text(model.authors[0] + " 他")
//            }else{
//                Text(model.authors[0])
//            }
//            }

            Spacer()
                }
        }
    }
}

//struct BookCell_Preview :  PreviewProvider {
//    static var previews: some View {
//        BookCell(model: INIT_BOOK_MODEL)
//    }
//}
