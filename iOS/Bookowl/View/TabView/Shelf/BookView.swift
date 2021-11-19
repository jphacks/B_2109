//
//  BookView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct BookView: View {
    var model : BookModel
    @State var isPushed = false
    @State var isUpdated  = false
    @State var width = ""
    @State var request = Bookowl_UpdateBookmarkIDRequest()
    @ObservedObject var isReload : reloadModel
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @ObservedObject var bookAPI : BookAPI
    @State private var progressAmount = 0
    var body: some View {
        ZStack{
            Bookowl.background
                .edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                URLImageView(viewModel: .init(url: model.imagePath))
                    .frame(width: 50, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(model.name)
                    .font(.title)
                    .foregroundColor(brown)
            }
            .padding(10)
            HStack{
//                Text("進捗 : " + String(model.progress) + " %")
                Text("進捗 : " + String(model.progress) + " %")
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
                    if progressAmount < Int(model.progress){
                        progressAmount += 1
                    }else{
                        timer.upstream.connect().cancel()
                    }
                })
            Group  {
                  Text("読む場合はしおりを登録してください。")
                  HStack{
                      Button( action: {
                          request.bookmarkID = 1
                          isPushed = true
                      }){
                      Image("bookmark1owl")
                          .resizable()
                          .frame(width: 80, height: 80, alignment: .center)}
                      Button( action: {
                          request.bookmarkID = 2
                          isPushed = true
                      }){
                      Image("bookmark2owl")
                          .resizable()
                          .frame(width: 80, height: 80,  alignment: .center)}
                      Button( action: {
                          request.bookmarkID = 3
                          isPushed = true
                      }){
                      Image("bookmark3owl")
                          .resizable()
                          .frame(width: 80, height: 80, alignment: .center)}
                      Button( action: {
                          request.bookmarkID = 4
                          isPushed = true
                      }){
                      Image("bookmark4owl")
                          .resizable()
                          .frame(width: 80, height: 80, alignment: .center)
                      }
                  }
                Button(action: {
                    request.bookID = model.bookId
                    request.bookmarkID = 0
                    bookAPI.UpdateBookmarkIDRequest(request: self.request)
                    var statusRequest = Bookowl_UpdateReadStatusRequest()
                    statusRequest.bookID = model.bookId
                    statusRequest.readStatus = .readUnread
                    bookAPI.UpdateReadStatusRequest(request: statusRequest)
                   isUpdated = true
                }){ Text("しおりを登録しない")
                          .font(.title)
                          .foregroundColor(brown)
              }
              
            }
              if isPushed{
              TextFieldAlertView(text: $width, isShowingAlert: $isPushed, placeholder: "", isSecureTextEntry: false, title: "厚みを入力してください。", message: "スイッチを押して表示される数値を入力してください。", leftButtonTitle: "キャンセル", rightButtonTitle: "決定", leftButtonAction: nil, rightButtonAction: {
                      
                      request.bookWidth = UInt64(width)!
                      bookAPI.UpdateBookmarkIDRequest(request: request)
                  var statusRequest = Bookowl_UpdateReadStatusRequest()
                  statusRequest.bookID = model.bookId
                  statusRequest.readStatus = .readReading
                  bookAPI.UpdateReadStatusRequest(request: statusRequest)
                  isPushed = false
                  isUpdated = true
                  
              })
              }
          
            Button(action: {
                var bookmarkRequest = Bookowl_UpdateBookmarkIDRequest()
                bookmarkRequest.bookID = model.bookId
                bookmarkRequest.bookWidth = 0
                bookmarkRequest.bookmarkID = 0
                bookAPI.UpdateBookmarkIDRequest(request: bookmarkRequest )
                var statusRequest = Bookowl_UpdateReadStatusRequest()
                statusRequest.bookID = model.bookId
                statusRequest.readStatus = .readComplete
                bookAPI.UpdateReadStatusRequest(request: statusRequest)
                isUpdated = true
            }){Text("完読！！！").foregroundColor(red).font(.title)}
                                                
            Spacer()
            
        }.alert(isPresented: $isUpdated) {
            
            Alert(title: Text("本の登録が完了しました。"), message: Text(""), dismissButton: .default(Text("はい")){
//                isFindBarcode = false
                
                isUpdated = false
                isReload.isReload = true
//                isFinish = true
            })
            
            
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
