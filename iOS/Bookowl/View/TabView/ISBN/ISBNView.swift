//
//  ISBNView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI

struct ISBNView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let backgroundColor = Color(red: 255/255, green: 241/255, blue: 179/255)
    @ObservedObject private var isbnReader = ISBNReader()
    @ObservedObject var viewModel : ScannerViewModel
    @State var isPutWidthLevel = false
    @State var widthLevel : String = ""
    @Binding var isActive : Bool
    @State var isFinish = false
    @ObservedObject var bookAPI : BookAPI
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
                        }.onChange(of: isFinish){
                            newValue in
                            if newValue == true{
                                self.isActive = false
//
                                print("changed!")
                            }
                        }
                
           
                
            
           
//        }
        
            
//    }
        
        }.fullScreenCover(isPresented: $viewModel.isLoading){
//            isbnReader.setIsISBNFind(bo: false)
            RegisterView(model:  viewModel.bookModel, isFindBarcode: $viewModel.isLoading, isFinish: $isFinish,bookAPI: bookAPI)
        }
        
//        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

//struct ISBNView_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = ScannerViewModel()
//        ISBNView(viewModel: model)
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
