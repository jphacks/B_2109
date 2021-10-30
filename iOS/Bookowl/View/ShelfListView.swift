//
//  ShelfListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI

struct ShelfListView: View {
    var books : [Book]
    var body: some View {
        ZStack {
            Color(red: 100/255, green: 95/255, blue: 70/255)
                .edgesIgnoringSafeArea(.all)
                
            List(books){ sensor in
                let label : String = sensor.name + ":" + String(sensor.name)
                Button(label, action: {
                   print("pushed!")
                })
        }
        }
    }
}

struct ShelfListView_Previews: PreviewProvider {
    static var previews: some View {
        let books = [Book(id: "1", name: "ringo"), Book(id: "2", name: "b")]
        ShelfListView(books: books)
        
    }
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
