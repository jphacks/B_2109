//
//  ChooseBattleMember.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI

struct ChooseBattleMember: View {
    @ObservedObject var follows = UserModels()
    @ObservedObject var matchAPI = MatchAPI()
    @ObservedObject var users = UserModels()
    @State var showIndicator = false
    @State var isFollowView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                backgroundColor.edgesIgnoringSafeArea(.all)
                VStack{
                    List{
                        ForEach(follows.userModels,id: \.id){
                            model in
                            RankingCell(model: model)
                                .listRowBackground(backgroundColor)
                        }
                    }
                }
                LoadingIndicatorView(isLoading: showIndicator)
            }
            .navigationTitle("進捗ランキング")
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                    NavigationLink( "フォロー追加", destination: UserListView(users: _users, matchAPI: _matchAPI, follows: _follows)
                                        .onDisappear(perform: {
                        isFollowView = false
                            print("userListViewDisappear")
                        })
                        .onAppear(perform: {
                    isFollowView = true
                    print("list appear")
                })
                    )
                )
            .onAppear{
                print("onAppear!!")
                if isFollowView{
                    matchAPI.updateFollowUsers(models: users)
                }
                follows.setList(models: matchAPI.getFollows())
                users.setList(models: matchAPI.getUserList(models: follows.userModels))
            }.onChange(of: matchAPI.isAPICalling, perform: {
                newValue in
                if newValue == true{
                    print("loading")
                    showIndicator = true
//                    isFinished = false
                }else{
                    print("finished")
                    showIndicator = false
//                    isFinished = true
                }
            })
               
        }
    }
}

struct ChooseBattleMember_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBattleMember()
    }
}
