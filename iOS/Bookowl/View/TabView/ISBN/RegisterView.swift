//
//  RegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI

struct RegisterView: View {
    var isbn : String
    @State var bookInfo : BookModel
    @State var isUpdated = false
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let bookAPI = BookAPI()
    var body: some View {
        ZStack{
            Bookowl.background.edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("owl")
                    .resizable()
                    .frame(width: 150, height: 200, alignment: .center)
                Text("タイトル")
                .font(.largeTitle)
                .foregroundColor(brown)
                .frame(width: 300, height: 20, alignment: .leading)
                .padding(20)
                Text("著者名")
                    .font(.title)
                    .foregroundColor(brown)
                    .frame(width: 300, height: 20, alignment: .leading)
                    .padding(20)
                HStack{
                Text("ページ数")
                    .font(.title)
                    .foregroundColor(brown)
                    .frame(width: 150, height: 20, alignment: .leading)
                    .padding(20)
                    Text("価格")
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
                Text("登録するしおりの番号をタップしてください。\n 積む場合は積読ボタンをタップしてください。")
                    .font(.title2)
                    .foregroundColor(brown)
                    .padding(50)
                HStack{
                   ForEach((0...4), id: \.self ){ i in
                   Button(action: {
                       print(i)
                       bookInfo.bookMarkId = UInt64(i)
                       bookAPI.UpdateBookmarkIDRequest(model: bookInfo)
                   }, label: {
                       if i == 0{
                           Spacer()
                           Text("積読")
                               .font(.title)
                               .foregroundColor(brown)
                               .frame(width: 150, height: 50, alignment: .center)
                           Spacer()
                       }
                       else{
                           Text( "\(i)")
                               .font(.title)
                               .foregroundColor(brown)
                               .frame(width: 150, height: 50, alignment: .center)
                            
//                           if i != 4{
                               Spacer()
//                           }
                       }
                   })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(orange,lineWidth: 2)
                           )
                           
                   }
                
            }
            
            
        }
        }
    }

}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let isbn = ""
        let bookModel = INIT_BOOK_MODEL
        RegisterView(isbn: isbn, bookInfo: bookModel )
    }
}

