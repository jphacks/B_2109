//
//  GoalModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftProtobuf

class GoalModel :ObservableObject {
    var Id : Int = 0
    var progress : Float = 0.0
    var startDate : SwiftProtobuf.Google_Protobuf_Timestamp = SwiftProtobuf.Google_Protobuf_Timestamp()
    var endDate : SwiftProtobuf.Google_Protobuf_Timestamp = SwiftProtobuf.Google_Protobuf_Timestamp()
    var time_amount_minutes = 0
    var num_pages  =  0
    var goal_status : Bookowl_GoalStatus =  Bookowl_GoalStatus.goalPending
}
