//
//  UserListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI
import GRPC
class UserModels : ObservableObject{
    @Published var userModels : [UserModel] = []
//    [UserModel(userId: 2, name: "aaaaa", numPages: 0, rank: 1, isFollow: false) ,UserModel(userId: 3, name: "aaaaa", numPages: 0, rank: 1, isFollow: false),UserModel(userId: 4, name: "aaaaa", numPages: 0, rank: 1, isFollow: false)  ]
    
    func append(model : UserModel){
        userModels.append(model)
    }
    func clear(){
        userModels = []
    }
    func setList(models : [UserModel]){
        self.userModels = models
    }
}

struct UserListView: View {
    @ObservedObject var users : UserModels
    @ObservedObject var matchAPI : MatchAPI
    @ObservedObject var follows : UserModels
    
    init(users:ObservedObject<UserModels>, matchAPI:ObservedObject<MatchAPI>,follows : ObservedObject<UserModels>){
        //List全体の背景色の設定
        UITableView.appearance().backgroundColor = UIColor(backgroundColor)
//        self._bookAPI = bookAPI
        self._users = users
        self._matchAPI = matchAPI
        self._follows = follows
    }
    
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                List{
                    ForEach(users.userModels,id: \.id){
                        model in
                        UserCell(model: model)
                            .listRowBackground(backgroundColor)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-70, alignment: .center)
        .navigationTitle("ユーザリスト")
            .navigationBarTitleDisplayMode(.inline)

    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(matchAPI: <#MatchAPI#>, follows: <#UserModels#>)
//    }
//}
