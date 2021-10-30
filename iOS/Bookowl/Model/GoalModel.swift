//
//  GoalModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftProtobuf

struct GoalModel : Codable {
    var Id : Int = 0
    var progress : Float = 0.0
    var startDate : String = ""
    var endDate : String = ""
    var time_amount_minutes : Int = 0
    var num_pages :Int =  0
    var goal_status : Int = Bookowl_GoalStatus.goalPending.rawValue
}

class GoalModelParser : NSObject, ObservableObject{
    @Published var hasGoalModel : Bool = false
    @Published var model : GoalModel!
    override init() {
        super.init()
        self.model = decodeToGoalModel()
    }
    
    func decodeToGoalModel() -> GoalModel?{
        guard let data = UserDefaults.standard.data(forKey: "goalModel"),
        let goalModel = try? JSONDecoder().decode(GoalModel.self, from: data) else {
            return nil
        }
        hasGoalModel = true
        return goalModel
    }
}

