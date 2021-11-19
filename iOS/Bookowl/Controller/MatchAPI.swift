//
//  MatchAPI.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import Foundation
import GRPC

class MatchAPI : ObservableObject{
    
    func getRanking(){
        
    }
    @Published var isAPICalling = false
    
    
    func getUserList(models:[UserModel]) -> [UserModel]{
        isAPICalling = true
        print("userList")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
        let idSet = Set(models.map{ $0.userId })
        var request = Bookowl_GetUserRequest()
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
            do {
                let client = Bookowl_MatchClient.init(channel: connection, defaultCallOptions: CallOptions())
                let response = try client.getUsers(request, callOptions: CallOptions()).response.wait()
                var users : [UserModel] = []
                for user in response.usersInfo{
                    if !idSet.contains(user.id){
                        let userModel = UserModel(userId: user.id, name: user.name, numPages: 0, rank: 0, isFollow: false)
                        users.append(userModel)
                    }else{
                        if user.id != USER_ID{
                            let userModel = UserModel(userId: user.id, name: user.name, numPages: 0, rank: 0, isFollow: true)
                            users.append(userModel)
                        }
                    }
                }
                isAPICalling = false
                return users
            }catch let error{
                print(error)
                isAPICalling = false
            }
        isAPICalling = false
        return []
    }
    
    func updateFollowUsers(models:UserModels){
        isAPICalling = true
        print("followUpdate")
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
//        フォローがついているユーザを抽出
        var request = Bookowl_RegisterOpponentsRequest()
        var newFollows : [UserModel] = []
        request.userID = UInt64(USER_ID)
        for model in models.userModels{
            if model.isFollow{
                request.opponentIds.append(model.userId)
                newFollows.append(model)
                print(model.userId)
            }
        }
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do {
            let client = Bookowl_MatchClient.init(channel: connection, defaultCallOptions: CallOptions())
            let responce = try client.registerOpponents(request, callOptions: CallOptions()).response.wait()
            print("register follows")
            isAPICalling = false
        }catch let error{
            print(error)
            isAPICalling = false
        }
        
    }
    
    func getFollows()-> [UserModel]{
        isAPICalling = true
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer{
            try? group.syncShutdownGracefully()
        }
//        フォローがついているユーザを抽出
        var request = Bookowl_GetRankingRequest()
        request.userID = UInt64(USER_ID)
        let connection = ClientConnection
            .insecure(group: group)
            .connect(host: address, port: port)
        do {
            let client = Bookowl_MatchClient.init(channel: connection, defaultCallOptions: CallOptions())
            let responce = try client.getRanking(request, callOptions: CallOptions()).response.wait()
            var models : [UserModel] = []
            for follow in responce.rankingInfos{
                let model = UserModel(userId: follow.id, name: follow.name, numPages: UInt64(follow.readPages), rank: UInt64(follow.ranking) , isFollow: true)
                
                models.append(model)
            }
            print("register follows")
            isAPICalling = false
            return models.sorted(by: {if $0.rank == $1.rank{
               return $0.userId < $1.userId
            }else{
                return $0.rank < $1.rank
            }
            })
        }catch let error{
            isAPICalling = false
            print(error)
            return []
        }
    }
    
}
