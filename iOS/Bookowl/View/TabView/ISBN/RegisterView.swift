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
    @State var isPushed = false
    @State var request = Bookowl_UpdateBookmarkIDRequest()
    @Binding var isFindBarcode : Bool
    @Binding var isFinish : Bool
    @State var width = ""
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    @ObservedObject var bookAPI : BookAPI
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
                            
                            request.bookmarkID = 1
                            
                            model.readStatus = .readReading
                            
                            isPushed = true
                        }){
                        Image("bookmark1owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            request.bookmarkID = 2
                            model.readStatus = .readReading
                            
                            isPushed = true
                        }){
                        Image("bookmark2owl")
                            .resizable()
                            .frame(width: 80, height: 80,  alignment: .center)}
                        Button( action: {
                            request.bookmarkID = 3
                            model.readStatus = .readReading
                            
                            isPushed = true
                        }){
                        Image("bookmark3owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)}
                        Button( action: {
                            request.bookmarkID = 4
                            model.readStatus = .readReading
                            
                            isPushed = true
                        }){
                        Image("bookmark4owl")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        }
                            
                    }
                  
                  Button(action: {
                      request.bookID = model.bookID
                      request.bookmarkID = 0
                      model.readStatus = .readUnread
                      bookAPI.UpdateBookmarkIDRequest(request: self.request)
                      var statusRequest = Bookowl_UpdateReadStatusRequest()
                      statusRequest.bookID = model.bookID
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
                    statusRequest.bookID = model.bookID
                    statusRequest.readStatus = .readReading
                    bookAPI.UpdateReadStatusRequest(request: statusRequest)
                    isPushed = false
                    isUpdated = true
                    
                })
                }
            }
       
            
            
        } .alert(isPresented: $isUpdated) {
            
            Alert(title: Text("本の登録が完了しました。"), message: Text(""), dismissButton: .default(Text("はい")){
                isFindBarcode = false
                isUpdated = false
                isFinish = true
            })
            
            
        }
        
    }
}



struct TextFieldAlertView: UIViewControllerRepresentable {
    
    @Binding var text: String
    @Binding var isShowingAlert: Bool
    
    let placeholder: String
    let isSecureTextEntry: Bool
    let title: String
    let message: String
    
    let leftButtonTitle: String?
    let rightButtonTitle: String?
    
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlertView>) -> some UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<TextFieldAlertView>) {
        
        guard context.coordinator.alert == nil else {
            return
        }
        
        if !isShowingAlert {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        context.coordinator.alert = alert
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = text
            textField.delegate = context.coordinator
            textField.isSecureTextEntry = isSecureTextEntry
            textField.keyboardType = .asciiCapableNumberPad
        }
        
        if leftButtonTitle != nil {
            alert.addAction(UIAlertAction(title: leftButtonTitle, style: .default) { _ in
                alert.dismiss(animated: true) {
                    isShowingAlert = false
                    leftButtonAction?()
                }
            })
        }
        
        if rightButtonTitle != nil {
            alert.addAction(UIAlertAction(title: rightButtonTitle, style: .default) { _ in
                if let textField = alert.textFields?.first, let text = textField.text {
                    self.text = text
                }
                alert.dismiss(animated: true) {
                    isShowingAlert = false
                    rightButtonAction?()
                }
            })
        }
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: {
                isShowingAlert = false
                context.coordinator.alert = nil
            })
        }
    }
    
    func makeCoordinator() -> TextFieldAlertView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var alert: UIAlertController?
        var view: TextFieldAlertView
        
        init(_ view: TextFieldAlertView) {
            self.view = view
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.view.text = text.replacingCharacters(in: range, with: string)
            } else {
                self.view.text = ""
            }
            return true
        }
    }
}

struct TestTextfield: UIViewRepresentable {
    @Binding var text: String
    var keyType: UIKeyboardType
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
      textfield.keyboardType = keyType
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        toolBar.items = [doneButton]
        toolBar.setItems([doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
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

