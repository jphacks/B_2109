//
//  TopView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI


struct TopView: View {
    @State var progressAmount : Float = 0.0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @ObservedObject var goalModel = GoalModel()
    
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let green = Color(red: 143/255, green: 156/255, blue: 64/255)
    let background = Color(red: 255/255, green: 241/255, blue: 179/255)
    
    var body: some View {
            NavigationView{
                ZStack{
                    background
                        .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("目標：")
                    Text("現在の状態：" )
                    .frame(width: 200, height: 100, alignment: .leading)
                    .padding(10)
                ProgressView(value: progressAmount , total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: green))
                .frame(width: UIScreen.main.bounds.width-50, height: 150, alignment: .center)
                .foregroundColor(brown)
                .font(.largeTitle)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .onReceive(timer, perform: { _ in
                    if progressAmount < goalModel.progress{
                        progressAmount = progressAmount + 1
                    }else{
                        timer.upstream.connect().cancel()
                    }
                })
                }.navigationBarItems(trailing: NavigationLink( "新規目標追加", destination: GoalRegisterView()))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
            .previewDevice("iPhone 11 Pro")
    }
}