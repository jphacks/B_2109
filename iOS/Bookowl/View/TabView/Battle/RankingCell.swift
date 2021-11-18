//
//  RankingCell.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/18.
//

import SwiftUI

struct RankingCell: View {
    @ObservedObject var model : UserModel
    var body : some View{
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
        HStack {
            Spacer()
            Text(String(model.rank))
            
            Text(String(model.userId))
            
            Text(model.name)
                .padding(10)
            
            Text(String(model.numPages))
            
            if model.userId == USER_ID{
                Text("(あなた)")
            }
            
            Spacer()
               
            }
        }
    }

}

struct RankingCell_Previews: PreviewProvider {
    static var previews: some View {
        var model = UserModel(userId: 6, name: "naa", numPages: 0, rank: 0, isFollow: false)
        RankingCell(model: model)
    }
}
