//
//  ISBNView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI
let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
let backgroundColor = Color(red: 255/255, green: 241/255, blue: 179/255)
struct ISBNView: View {
    @ObservedObject private var isbnReader = ISBNReader()
    @ObservedObject var viewModel : ScannerViewModel
    @State var bookModel = BookModel(id: "", name: "", status: "", progress: 0, imagePath: "", bookMarkId: "")
    var bookmarkId : Int = 0
    var body: some View {
//        NavigationView{
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
//            NavigationLink(
//               destination: RegisterView(isbn: self.viewModel.lastQrCode),
//                isActive: self.$viewModel.isShowing){
                VStack {
                    VStack {
                        Text("使用するしおりの番号を選んでください。")
                            .font(.caption)
                            .foregroundColor(brown)
                        HStack{
                            ForEach((0...4), id: \.self ){ i in
                            Button(action: {
                                print(i)
                                self.bookModel.bookMarkId = String(i)
                               
                            }, label: {
                                if i == 0{
                                    Text("登録のみ")
                                }
                                else{
                                    Text( "\(i)")
                                }
                            })
                            }
                    }
                        Text("バーコード読み取り中．．．\n 978から始まるバーコードをかざしてください。")
                            .font(.caption)
                            .foregroundColor(brown)
                        
                        Text("バーコード読み取り結果 = [ " + self.viewModel.lastQrCode + " ]")
                    }
                    .padding(.vertical, 20)
//                    Spacer()
                
                ISBNScannerView()
                    .found(r: self.viewModel.onFoundQrCode)
                    .interval(delay: self.viewModel.scanInterval)
                    .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    

                }.padding()
                
       
           
//        }
        
            
//    }
        
        }.fullScreenCover(isPresented: $viewModel.isShowing){
            RegisterView(isbn: self.viewModel.lastQrCode, bookInfo: bookModel)
        }
//        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ISBNView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ScannerViewModel()
        ISBNView(viewModel: model)
            .previewDevice("iPhone 11 Pro")
    }
}
