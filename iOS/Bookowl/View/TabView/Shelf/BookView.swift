//
//  BookView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookView: View {
    @Binding var model : Bookowl_BookInfo
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    let bookAPI = BookAPI()
    @State private var progressAmount = 0
    var body: some View {
        ZStack{
            Bookowl.background
                .edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                URLImageView(viewModel: .init(url: model.bookThumbnail))
                    .frame(width: 50, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(model.name)
                    .font(.title)
                    .foregroundColor(brown)
            }
            .padding(10)
            HStack{
//                Text("進捗 : " + String(model.progress) + " %")
                Text("進捗 : " + "70" + " %")
                    .font(.largeTitle)
                    .frame(width: 200, height: 50, alignment: .leading)
                    .padding(10)
                    .foregroundColor(brown)
            }
            ProgressView(value: Float(progressAmount) , total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: green))
                .frame(width: UIScreen.main.bounds.width-50, height: 30, alignment: .center)
                .foregroundColor(brown)
                .font(.title)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .onReceive(timer, perform: { _ in
//                    あとで変える
                    if progressAmount < 60{
                        progressAmount += 1
                    }else{
                        timer.upstream.connect().cancel()
                    }
                })
                Text("読む場合はしおりを登録してください。")
                HStack{
                    Button( action: {
                        model.bookmarkID = 1
                        model.readStatus = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark1owl")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)}
                    Button( action: {
                        model.bookmarkID = 2
                        model.readStatus = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark2owl")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)}
                    Button( action: {
                        model.bookmarkID = 3
                        model.readStatus = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark3owl")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)}
                    Button( action: {
                        model.bookmarkID = 1
                        model.readStatus = .readReading
                        bookAPI.UpdateBookmarkIDRequest(model: model)
                    }){
                    Image("bookmark4owl")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                    }
//                    Spacer()
//                }
//            }else if model.readStatus == .readComplete{
//                Text("おめでとうございます！\nこの本を読み切りました。")
//                .font(.title)
//                .foregroundColor(brown)
//            }
            }
            Button(action: {
                model.bookmarkID = 0
                model.readStatus = .readComplete
                bookAPI.UpdateBookmarkIDRequest(model: model)
            }){Text("完読！！！").foregroundColor(red).font(.title)}
                                                
            Spacer()
            
        }
//    }
}
    


    }

}

//
//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            @State var model = Bookowl_BookInfo()
//            BookView(model:$model)
//                .previewDevice("iPhone 11")
//        }
//    }
//}
