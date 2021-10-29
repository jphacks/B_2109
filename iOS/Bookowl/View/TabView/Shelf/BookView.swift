//
//  BookView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookView: View {
    let model : BookModel
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
   
    @State private var progressAmount = 0
    var body: some View {
        ZStack{
            Bookowl.background
                .edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                Image(model.imagePath)
                    .resizable()
                    .frame(width: 150, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(10)
                Text(model.name)
                    .font(.largeTitle)
                    .foregroundColor(brown)
                
                
            }
            .padding(40)
            HStack{
                Text("進捗 : " + String(model.progress) + " %")
                    .font(.largeTitle)
                    .frame(width: 200, height: 100, alignment: .leading)
                    .padding(30)
                    .foregroundColor(brown)
                Spacer()
            }
            ProgressView(value: Float(progressAmount) , total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: green))
                .frame(width: UIScreen.main.bounds.width-50, height: 150, alignment: .center)
                .foregroundColor(brown)
                .font(.largeTitle)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .onReceive(timer, perform: { _ in
                    if progressAmount < model.progress{
                        progressAmount += 1
                    }else{
                        timer.upstream.connect().cancel()
                    }
                })
            if model.status == .readReading{
                Text("しおり番号：" + String(model.bookMarkId ))
            }
            
            Spacer()
        }
            
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookView(model:INIT_BOOK_MODEL )
                .previewDevice("iPhone 11")
        }
    }
}
