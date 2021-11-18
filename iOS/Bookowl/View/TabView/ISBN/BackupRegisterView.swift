//
//  RegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct RegisterView: View {
//    var isbn : String
    @State var isUpdated = false
    @Binding var isFindBarcode : Bool
    @Binding var isFinished : Bool
    @ObservedObject var viewModel:ScannerViewModel
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let bookAPI = BookAPI()
    var body: some View {
        ZStack{
            Bookowl.background.edgesIgnoringSafeArea(.all)
            
            VStack{
                
                URLImageView(viewModel: .init(url: viewModel.bookModel.bookThumbnail))
                    .frame(width: 150, height: 200, alignment: .center)
                Text(viewModel.bookModel.name)
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
                    Text("ページ数:" + String(viewModel.bookModel.pages))
                        .font(.title)
                    .foregroundColor(brown)
                    .frame(width: 150, height: 20, alignment: .leading)
                    .padding(20)
                    Text("価格:" + String(viewModel.bookModel.price))
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
                            viewModel.bookModel.bookmarkID = 1
                            viewModel.bookModel.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: viewModel.bookModel)
                            isUpdated = true
                        }){
                        Image("bookmark1owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            viewModel.bookModel.bookmarkID = 2
                            viewModel.bookModel.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: viewModel.bookModel)
                            isUpdated = true
                        }){
                        Image("bookmark2owl")
                            .resizable()
                            .frame(width: 80, height: 80,  alignment: .center)}
                        Button( action: {
                            viewModel.bookModel.bookmarkID = 3
                            viewModel.bookModel.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: viewModel.bookModel)
                            isUpdated = true
                        }){
                        Image("bookmark3owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            viewModel.bookModel.bookmarkID = 4
                            viewModel.bookModel.readStatus = .readReading
                            bookAPI.UpdateBookmarkIDRequest(model: viewModel.bookModel)
                            isUpdated = true
                        }){
                        Image("bookmark4owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        }
                            
                    }
                  
                  Button(action: {
                      viewModel.bookModel.bookmarkID = 0
                      viewModel.bookModel.readStatus = .readUnread
                      bookAPI.UpdateBookmarkIDRequest(model: viewModel.bookModel)
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
                isFinished = false
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

