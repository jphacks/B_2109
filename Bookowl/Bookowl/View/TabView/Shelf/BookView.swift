//
//  BookView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookView: View {
    let model : BookModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(model:BookModel(id: "1", name: "owl", status: "Unread", progress: "64", imagePath: "owl") )
    }
}
