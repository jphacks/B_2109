//
//  ISBNView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI

struct ISBNView: View {
    @Environment(\.presentationMode) var presentationMode
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let backgroundColor = Color(red: 255/255, green: 241/255, blue: 179/255)
    @ObservedObject var viewModel = ScannerViewModel()
    @State var isPutWidthLevel = false
    @State var widthLevel : String = ""
    @Binding var isActive : Bool
    var bookmarkId : Int = 0
    var body: some View {
//        NavigationView{
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
//            NavigationLink(
//               destination: RegisterView(isbn: self.viewModel.lastQrCode),
//                isActive: self.$viewModel.isShowing){
//                VStack {
//                    VStack {
//                        Text("使用するしおりの番号を選んでください。")
//                            .font(.caption)
//                            .foregroundColor(brown)
//                        HStack{
//                            ForEach((0...4), id: \.self ){ i in
//                            Button(action: {
//                                print(i)
//                                self.bookModel.bookMarkId = UInt64(i)
//
//                            }, label: {
//                                if i == 0{
//                                    Text("登録のみ")
//                                }
//                                else{
//                                    Text( "\(i)")
//                                }
//                            })
//                            }
//                    }
//                    if isPutWidthLevel{
                ZStack{
                ActivityIndicator(isAnimating: $viewModel.isShowing, style: .large)
                VStack{
                Text("バーコード読み取り中．．．\n 978から始まるバーコードをかざしてください。")
                    .font(.caption)
                    .foregroundColor(brown)
                
                Text("バーコード読み取り結果 = [ " + self.viewModel.lastQrCode + " ]")
            
            .padding(.vertical, 20)
//                    Spacer()
                        ISBNScannerView()
                           .found(r: self.viewModel.onFoundQrCode)
                           .interval(delay: self.viewModel.scanInterval)
                           .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                }
                }.fullScreenCover(isPresented: $viewModel.isLoading){
                    //            isbnReader.setIsISBNFind(bo: false)
                                RegisterView(isFindBarcode: $viewModel.isLoading,isFinished: $isActive, viewModel: viewModel)
                    //        .navigationViewStyle(StackNavigationViewStyle())
                            
                            }
//                }else{
//                    VStack{
//                    Text("ディスプレイのスイッチをオンにしてください。\n 次に，全ページをしおりで挟んでください。 \n ディスプレイに表示されている数値を入力してください。")
//                            .font(.headline)
//                        .foregroundColor(brown)
//                        .padding(20)
//
//                        TextField("数値を入力してください。", text: $widthLevel, onCommit: {
//                            print("onCommit")
////                            viewModel.bookModel.widthLevel = Int64(widthLevel)!
//                            print(widthLevel)
//                        })
//                            .keyboardType(.numberPad)
//                            .padding(20)
//                            .frame(width: 200, height: 50, alignment: .center)
//                        Button("決定"){
////                            viewModel.bookModel.widthLevel = Int64(widthLevel)!
//                            print(widthLevel)
//                            isPutWidthLevel = true
//                        }
//                        Spacer()
//                    }
//
//                }
                
            
           
//        }
        
            
//    }
        
        }
//        .onChange(of: isActive){
//            newValue in
//            if newValue == false{
//                presentationMode.wrappedValue.dismiss()
//            }
//        }
    }
    
}

//struct ISBNView_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = ScannerViewModel()
//        var bool = false
//        ISBNView(viewModel: model, isActive: bool)
//            .previewDevice("iPhone 11 Pro")
//    }
//}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
