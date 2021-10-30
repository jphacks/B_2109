//
//  RegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct RegisterView: View {
//    var isbn : String
    @State var model : Bookowl_BookInfo
    @State var isUpdated = false
    @Binding var isFindBarcode : Bool
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let bookAPI = BookAPI(viewName: "register")
    var body: some View {
        ZStack{
            Bookowl.background.edgesIgnoringSafeArea(.all)
            
            VStack{
                URLImageView(viewModel: .init(url: model.bookThumbnail))
                    .frame(width: 150, height: 200, alignment: .center)
                Text(model.name)
                .font(.title)
                .foregroundColor(brown)
                .frame(width: 300, height: 20, alignment: .leading)
//                .padding(20)
//                Text()
//                    .font(.title)
//                    .foregroundColor(brown)
//                    .frame(width: 300, height: 20, alignment: .leading)
//                    .padding(20)
                HStack{
                    Text("ページ数:" + String(model.pages))
                        .font(.title)
                    .foregroundColor(brown)
                    .frame(width: 150, height: 20, alignment: .leading)
                    .padding(20)
                    Text("価格:" + String(model.price))
                        .font(.title)
                        .foregroundColor(brown)
                        .frame(width: 150, height: 20, alignment: .leading)
                        .padding(20)
                }
//                Spacer()
//                Text("この本を登録しました。")
//                    .font(.title)
//                    .foregroundColor(brown)
//
//                    .padding(20)
              Group  {
                    Text("読む場合はしおりを登録してください。")
                    HStack{
                        Button( action: {
                            model.bookmarkID = 1
                            model.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: model)
                            isUpdated = true
                        }){
                        Image("bookmark1owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            model.bookmarkID = 2
                            model.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: model)
                            isUpdated = true
                        }){
                        Image("bookmark2owl")
                            .resizable()
                            .frame(width: 80, height: 80,  alignment: .center)}
                        Button( action: {
                            model.bookmarkID = 3
                            model.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: model)
                            isUpdated = true
                        }){
                        Image("bookmark3owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            model.bookmarkID = 4
                            model.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: model)
                            isUpdated = true
                        }){
                        Image("bookmark4owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        }
                            
                    }
                  
                  Button(action: {
                      model.bookmarkID = 0
                      model.readStatus = .readUnread
                      bookAPI.UpdateBookmarkIDRequest(model: model)
                     isUpdated = true
                  }){ Text("しおりを登録しない")
                            .font(.title)
                            .foregroundColor(brown)
                }
                
              }
        }
        } .alert(isPresented: $isUpdated) {
            Alert(title: Text("本の登録が完了しました。"), message: Text(""), dismissButton: .default(Text("はい")){
                isFindBarcode = false
                isUpdated = false
            })
            
            
        }
        
    }
}


//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        let isbn = ""
//        let bookModel = INIT_BOOK_MODEL
//        @Binding var bool : Bool
//        RegisterView(model: bookModel, isFindBarcode: bool )
//    }
//}

