//
//  BookView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookView: View {
    var model : Bookowl_BookInfo
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    let bookAPI = BookAPI(viewName: "book")
    @State private var progressAmount = 0
    var body: some View {
        ZStack{
            Bookowl.background
                .edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                URLImageView(viewModel: .init(url: model.bookThumbnail))
                    .frame(width: 150, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(10)
                Text(model.name)
                    .font(.title)
                    .foregroundColor(brown)
                
                
            }
            .padding(40)
            HStack{
//                Text("進捗 : " + String(model.progress) + " %")
                Text("進捗 : " + "70" + " %")
                    .font(.largeTitle)
                    .frame(width: 200, height: 100, alignment: .leading)
                    .padding(30)
                    .foregroundColor(brown)
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
            
                if self.model.status == .readReading {
                    VStack{
                Text("しおり番号：" + String(model.bookMarkId ))
                Button(action: {
                    model.status = .readComplete
                    bookAPI.UpdateBookmarkIDRequest(model: model)
                }) {Text("読了")
                        .font(.largeTitle)
                        .foregroundColor(brown)
                        .frame(width: 400, height: 80, alignment: .center)
            }
                    }
            }else if model.status == .readUnread || model.status == .readSuspended {
                VStack{
                Text("読む場合はしおりを登録してください。")
                HStack{
                    Button( action: {
                        model.bookMarkId = 1
                        model.status = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark1owl")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)}
                    Button( action: {
                        model.bookMarkId = 2
                        model.status = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark2owl")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)}
                    Button( action: {
                        model.bookMarkId = 3
                        model.status = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark3owl")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)}
                    Button( action: {
                        model.bookMarkId = 1
                        model.status = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark4owl")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    }
                        
                }
                }
            }else if model.readStatus == .readComplete{
                Text("おめでとうございます！\nこの本を読み切りました。")
                .font(.title)
                .foregroundColor(brown)
            }
            }
            Spacer()
        }
    }
}
    


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookView(model:unReadModels[0])
                .previewDevice("iPhone 11")
        }
    }
}
