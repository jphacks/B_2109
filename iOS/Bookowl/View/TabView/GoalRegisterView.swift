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
                
                TextField("何ページ読むかを入力", text: $page, onEditingChanged: {_ in print("change") }, onCommit: {print("commit") })
                
                Button(action: {
                    var model = GoalModel()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    dateFormatter.timeZone =
                    TimeZone(identifier: "Asia/Tokyo")
                    model.startDate = dateFormatter.string(from: selectionStartDate)
                      
                    model.endDate = dateFormatter.string(from: selectionEndDate)
                    if page == nil{
                        model.num_pages = 10
                    }else{
                        model.num_pages = Int(page)!
                    }
                    
                    let json = JSONEncoder()
                    guard let data = try? json.encode(model) else{
                        return
                    }
                    
                    UserDefaults.standard.set(data, forKey: "goalModel")
                    
//                    guard let data = UserDefaults.standard.data(forKey: "goalModel"),
//                          let goalModel = try? JSONDecoder().decode(GoalModel.self, from: data) else {
//                        return
//                    }
                    
//                    print(goalModel.startDate)
//                    model.time_amount_minutes = Int(hour)!
//                    goalAPI.sendRegisterGoalrequest(model: model)
//                    goalAPI.getGoalByUserId()
//                    UserDefaults.standard.set(model, forKey: "goalModel"
//                    )
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
            GoalRegisterView()
    }
}

