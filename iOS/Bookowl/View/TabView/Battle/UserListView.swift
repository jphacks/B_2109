//
//  UserListView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI
class UserModels : ObservableObject{
    @Published var userModels : [UserModel] = []
    func append(model : UserModel){
        userModels.append(contentsOf: model)
    }
    func clear(){
        userModels = []
    }
}
struct UserListView: View {
    @ObservedObject var modelList = UserModels()
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            List{
                ForEach($modelList.userModels,id:\.userId){
                    model in
                    UserCell(model: model)
                }
            }
        }.navigationTitle("ユーザリスト")
            .navigationBarTitleDisplayMode(.inline)
            
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
