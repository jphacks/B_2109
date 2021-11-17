//
//  UserCell.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI

struct UserCell: View {
    var model : UserModel
    
    var body : some View{
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
        HStack {
            Spacer()
            Text(model.userId)
            
            Text(model.name)
                .padding(10)
            
            Text(model.numPages)


            Spacer()
            }
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(model: UserModel())
    }
}
