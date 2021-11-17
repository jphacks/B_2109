//
//  ChooseBattleMember.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI

struct ChooseBattleMember: View {
    var body: some View {
        NavigationView{
            ZStack{
                backgroundColor.edgesIgnoringSafeArea(.all)
                VStack{
                    Text("進捗")
                } .navigationTitle("進捗ランキング")
                    .navigationViewStyle(.stack)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: NavigationLink( "フォロー追加", destination: UserListView()))
            }
               
        }
    }
}

struct ChooseBattleMember_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBattleMember()
    }
}
