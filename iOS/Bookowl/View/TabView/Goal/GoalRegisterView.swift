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
    @ObservedObject var goalModelParser : GoalModelParser
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            background.edgesIgnoringSafeArea(.all)
            VStack{
                let date2 = date1.addingTimeInterval(365*100*60*60)
                Text("目標設定")
                
                TextField("何ページ読むかを入力", text: $page, onEditingChanged: {_ in print("change") }, onCommit: {print("commit") })
                    .keyboardType(.numberPad)
                
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
                    
                    goalModelParser.saveModel(model: model)
                    presentationMode.wrappedValue.dismiss()

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
        let parser = GoalModelParser()
            GoalRegisterView(goalModelParser: parser)
    }
}

