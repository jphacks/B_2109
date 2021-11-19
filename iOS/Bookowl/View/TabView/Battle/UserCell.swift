//
//  UserCell.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI
import GRPC

struct UserCell: View {
    @ObservedObject var model : UserModel
    var body : some View{
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
        HStack {
            Spacer()
//            Text(String(model.userId))
            
            Text(model.name)
                .padding(10)
            
            Spacer()
            
            Button(action:{
                model.isFollow.toggle()
            }){
                if model.isFollow{
                    Text("フォロー")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .frame(width: 120, height: 50, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 10).fill(red))
                                    // 枠線を描画
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(red, lineWidth: 2))
                        
                }else{
                    Text("フォロー")
                        .foregroundColor(brown)
                        .fontWeight(.medium)
                        .frame(width: 120, height: 50, alignment: .center)
                                    // 枠線を描画
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(red, lineWidth: 2))
                }
            }

            Spacer()
               
            }
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(model: UserModel(userId: 2, name: "aaaaa", numPages: 0, rank: 1, isFollow: false) )
    }
}
