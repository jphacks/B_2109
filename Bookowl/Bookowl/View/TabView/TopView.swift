//
//  TopView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 241/255, blue: 179/255)
                .edgesIgnoringSafeArea(.all)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
            .previewDevice("iPhone 11 Pro")
    }
}
