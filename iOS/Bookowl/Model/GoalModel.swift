//
//  GoalModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftProtobuf

struct GoalModel : Codable, Identifiable {
    var id: Int = 0
    var progress : Float = 0.0
    var startDate : String = ""
    var endDate : String = ""
    var time_amount_minutes : Int = 0
    var num_pages :Int =  0
    var goal_status : Int = Bookowl_GoalStatus.goalPending.rawValue
}

class GoalModelParser : NSObject, ObservableObject{
    @Published var hasGoalModel : Bool = false
    @Published var model = GoalModel()
    override init() {
        super.init()
        decodeToGoalModel()
    }
    func saveModel(model:GoalModel){
        UserDefaults.standard.set(true, forKey: CurrentUserDefaults.goal)
        UserDefaults.standard.set(model.num_pages, forKey: "page")
        let json = JSONEncoder()
        guard let data = try? json.encode(model) else{
            return
        }
        UserDefaults.standard.set(data, forKey: "goalModel")
        self.model = model
    }
    
    
    func decodeToGoalModel(){
        let page = UserDefaults.standard.integer(forKey: "page")
        self.hasGoalModel = true
        self.model.num_pages = page
        print(self.model.num_pages)
        
    }
}

