//
//  GoalRegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/29.
//

import Foundation
//
//  RegisterView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import SwiftUI
import SwiftProtobuf
struct GoalRegisterView: View {
    let background = Color(red: 255/255, green: 241/255, blue: 179/255)
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let date1 = Date()
    @State var hour = ""
    @State var page = ""
    @State private var selectionStartDate = Date()
    @State private var selectionEndDate = Date()
    @ObservedObject var goalAPI = GoalRegisterAPI()
    var body: some View {
        ZStack{
            background.edgesIgnoringSafeArea(.all)
            VStack{
                let date2 = date1.addingTimeInterval(365*100*60*60)
                Text("目標設定")
                DatePicker("開始日時を選択", selection: $selectionStartDate, in: date1...date2,displayedComponents: .date)
                DatePicker("終了日時を選択", selection: $selectionEndDate, in: date1...date2,displayedComponents: .date)
                TextField("何時間読むかを入力", text: $hour, onEditingChanged: {_ in
                print("change")
                }, onCommit: {
                  print("commit")
                })
                
                TextField("何ページ読むかを入力", text: $page, onEditingChanged: {_ in print("change") }, onCommit: {print("commit") })
                
                Button(action: {
//                    let model = GoalModel()
//                    model.startDate = Google_Protobuf_Timestamp(date: selectionStartDate)
//                    model.endDate = Google_Protobuf_Timestamp(date:selectionEndDate)
//                    model.num_pages = Int(page)!
//                    model.time_amount_minutes = Int(hour)!
//                    goalAPI.sendRegisterGoalrequest(model: model)
                    goalAPI.getGoalByUserId()
                }
                    , label: {
                    Text("決定")
                })
                    
            }
        }
        }
    }



struct GoalRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let isbn = ""
        let bookModel = BookModel(id: "0", name: "a", status: "2", progress: 53, imagePath: "0", bookMarkId: "0")
        GoalRegisterView()
    }
}

