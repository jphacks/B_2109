//
//  GoalRegisterApi.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/29.
//
import Foundation
import GRPC
class GoalRegisterAPI : NSObject, ObservableObject{

    override init() {
        super.init()
    }
    
    func sendRegisterGoalrequest(model : GoalModel){
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        let connection = ClientConnection
            .secure(group: group)
            .connect(host: "163.221.29.71", port: 8080)
//        let client = Bookowl_GoalClient.init(channel:connection )
        var request = Bookowl_CreateGoalRequest()
        
        request.goalInfo.goalStatus = .goalDoing
        request.goalInfo.startDate = model.startDate
        request.goalInfo.endDate = model.endDate
        request.goalInfo.numPages = Int64(model.num_pages)
        request.goalInfo.timeAmountMinutes = Int64(model.time_amount_minutes)
        request.goalInfo.userID = 1
        print("aaa")
        do {
            let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
            let call = client.createGoal(request, callOptions: CallOptions())
            let response = try call.response.wait()
            print("response!!!")
            print(response.goalID)
        } catch {
            print("error!!!!")
            print(error)
        }

    }
    
    func getGoalByUserId(){
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        let connection = ClientConnection
            .secure(group: group)
            .connect(host: "163.221.29.71", port: 8080)
//        let client = Bookowl_GoalClient.init(channel:connection )
        var request = Bookowl_GetGoalByUserIDRequest()
        request.userID = 1
        let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
        let call = client.getByUserID(request)
        
        print("aaa")
//        do {
//            let response = try client.getByUserID(request, callOptions: CallOptions()).response.wait()
//            print(response.time)
//        }catch let e{
//            print(e.localizedDescription)
//        }
//        call.response.whenSuccess({res in print(res.time)})
        
//        let response = try? call.response.wait()
//        print(response)
//        call.response.whenFailure({
//            error in
//            print(error)
//        })
    }
    
}
