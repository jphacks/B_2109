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
    var id: UInt64 = 0
    var progress : Float = 0.0
    var startDate = Date()
    var endDate = Date()
    var time_amount_minutes : Int = 0
    var num_pages :Int64 =  550
    var goal_status : Int = Bookowl_GoalStatus.goalPending.rawValue
}

class GoalModelParser : NSObject, ObservableObject{
    enum WeekDay: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
    }
    @Published var hasGoalModel : Bool = false
    @Published var model = GoalModel()
    let DEFAULT_PAGE = 550
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
        RegisterGoalRequest(pages: Int64(model.num_pages))
    }
    
    
    func RegisterGoalRequest(pages:Int64) {
        print("GoalregisterAPI")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_CreateGoalRequest()
        request.userID = UInt64(USER_ID)
        request.time = Google_Protobuf_Timestamp.init(date: Date())
        request.numPages = Int64(pages)
        UserDefaults.standard.set(true, forKey: CurrentUserDefaults.goal)
        UserDefaults.standard.set(pages, forKey: "page")
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print("registered Goal")
                let client = Bookowl_GoalClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.createGoal(request, callOptions: CallOptions()).response.wait()
                model.id = response.goalInfo.goalID
                model.startDate = response.goalInfo.startDate.date
                model.endDate = response.goalInfo.endDate.date
                model.num_pages = response.goalInfo.numPages
            }catch let error{
                print(error)
            }

    }
    
    func decodeToGoalModel(){
        let page = UserDefaults.standard.integer(forKey: "page")
        if page == 0{
            self.model.num_pages = Int64(DEFAULT_PAGE)
            self.RegisterGoalRequest(pages: Int64(DEFAULT_PAGE))
        }else{
            self.model.num_pages = Int64(page)
        }
        print("pageDecode")
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
    
    func getMondaySunday()->[Date]{
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        let weekday = WeekDay(rawValue: Calendar.current.component(Calendar.Component.weekday, from: today))
        var startDay = Date()
        var endDay = Date()
        switch weekday {
        case .monday:
            startDay = Date()
            endDay = calendar.date(from: DateComponents(day:6))!
            break
        case .none:
            break
        case .some(.sunday):
            startDay = calendar.date(from: DateComponents(day:-6))!
            endDay = Date()
        case .some(.tuesday):
            startDay = calendar.date(from: DateComponents(day:-1))!
            endDay = calendar.date(from: DateComponents(day:5))!
        case .some(.wednesday):
            startDay = calendar.date(from: DateComponents(day:-2))!
            endDay = calendar.date(from: DateComponents(day:4))!
        case .some(.thursday):
            startDay = calendar.date(from: DateComponents(day:-3))!
            endDay = calendar.date(from: DateComponents(day:3))!
        case .some(.friday):
            startDay = calendar.date(from: DateComponents(day:-4))!
            endDay = calendar.date(from: DateComponents(day:2))!
        case .some(.saturday):
            startDay = calendar.date(from: DateComponents(day:-5))!
            endDay = calendar.date(from: DateComponents(day:1))!
        }
        
        return [startDay,endDay]
        
    }
    
    
    func getReadPagesWithDurationRequest()->Int{
        let date = getMondaySunday()
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetReadPagesWithDurationRequest()
        request.userID = UInt64(USER_ID)
        request.startTime = Google_Protobuf_Timestamp.init(date: date[0])
        request.endTime = Google_Protobuf_Timestamp.init(date: date[1])
        
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print("getDuration")
                let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.getReadPagesWithDuration(request, callOptions: CallOptions()).response.wait()
                return Int(response.readPages)

            }catch let error{
                print(error)
                return 0
            }
    }
    
    func getReadPagesRequest()->Int{
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetReadPagesRequest()
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.getReadPages(request, callOptions: CallOptions()).response.wait()
                print("getReadPages")
                print(response.readPages)
                return Int(response.readPages)

            }catch let error{
                print(error)
                return 0
            }
    }
    
    func getReadSeconds()->String?{
        
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        var request = Bookowl_GetReadSecondsRequest()
        request.userID = UInt64(USER_ID)
        
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                print("registered Goal")
                let client = Bookowl_BookClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.getReadSeconds(request, callOptions: CallOptions()).response.wait()
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .positional
                formatter.allowedUnits = [.minute,.hour,.second]
                formatter.unitsStyle = .short
                let output = formatter.string(from: TimeInterval(response.readSeconds))
                
                return output
            }catch let error{
                print(error)
                return "0秒"
            }
    }
    
}

