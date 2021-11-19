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
            ZStack(alignment: .center){
                if model.rank == 1{
                    Image("crown")
                        .resizable()
                        .frame(width: 70, height: 70, alignment: .top)
                        .foregroundColor(brown)
                        .offset(x: 0, y: -10)
                }
                Text(String(model.rank))
                    .foregroundColor(red)
                    .font(.title)
                    .frame(width: 70, height: 50, alignment: .center)
            }
            
            
//            Text(String(model.userId))
            if model.userId == USER_ID{
                Text(model.name)
                    .padding(10)
                    .foregroundColor(red)
                    .font(.headline)
                    .frame(width: 150, height: 50, alignment: .center)
                Text(String(model.numPages) + " ページ")
                    .foregroundColor(brown)
                    .font(.subheadline)
                    .foregroundColor(red)
            }else{
                Text(model.name)
                    .padding(10)
                    .foregroundColor(brown)
                    .font(.subheadline)
                    .frame(width: 150, height: 50, alignment: .center)
                Text(String(model.numPages) + " ページ")
                    .foregroundColor(brown)
                    .font(.subheadline)
                    .foregroundColor(brown)
            }

            Spacer()
               
            }
        }
    }

}

struct RankingCell_Previews: PreviewProvider {
    static var previews: some View {
        var model = UserModel(userId: 6, name: "五十嵐　双風", numPages: 0, rank: 0, isFollow: true)
        RankingCell(model: model)
    }
}
