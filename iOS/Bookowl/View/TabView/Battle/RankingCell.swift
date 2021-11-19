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
            ZStack(alignment: .center){
                Image("crown")
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .top)
                    .foregroundColor(brown)
                    .offset(x: 0, y: 0)
                Text(String(model.rank))
                    .foregroundColor(red)
                    .font(.title)
                    .frame(width: 50, height: 50, alignment: .center)
            }
            
            
//            Text(String(model.userId))
            
            Text(model.name)
                .padding(10)
                .foregroundColor(brown)
                .font(.subheadline)
            
            Text(String(model.numPages) + " ページ")
                .foregroundColor(brown)
                .font(.subheadline)
            
            if model.userId == USER_ID{
                Text("(あなた)")
                    .font(.subheadline)
                    .foregroundColor(brown)
                
            }else{
                Spacer()
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
