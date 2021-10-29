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
