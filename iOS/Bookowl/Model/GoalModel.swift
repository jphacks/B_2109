//
//  GoalModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//

import Foundation
import SwiftProtobuf
import GRPC
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
        RegisterBookRequest()
    }
    
    
    func RegisterBookRequest() {
        print("GoalregisterAPI")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_CreateGoalRequest()
        request.userID = UInt64(USER_ID)
        request.time = Google_Protobuf_Timestamp.init(date: Date())
        request.numPages = Int64(self.model.num_pages)

        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print("registered Goal")
                let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.createGoal(request, callOptions: CallOptions()).response.wait()

            }catch let error{
                print(error)
            }

    }
    
    func decodeToGoalModel(){
        let page = UserDefaults.standard.integer(forKey: "page")
        self.hasGoalModel = true
        self.model.num_pages = page
        print(self.model.num_pages)
        
    }
    
    func getGoal(){
        print("GoalregisterAPI")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetGoalsRequest()
        
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print("registered Goal")
                let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.getGoals(request, callOptions: CallOptions()).response.wait()
            }catch let error{
                print(error)
            }
    }
    
}

