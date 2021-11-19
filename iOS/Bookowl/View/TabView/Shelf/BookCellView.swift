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
            Spacer()
            URLImageView(viewModel: .init(url: model.imagePath))
                .frame(width: 100, height: 150)
                .padding(10)
//            VStack{
            Spacer()
            Text(model.name)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 200, height: 100)
                .padding(10)
                .font(.headline)
                .foregroundColor(brown)
                
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

struct BookCell_Preview :  PreviewProvider {
    static var previews: some View {
        BookCell(model: unReadModels[0])
    }
}
