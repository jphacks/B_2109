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
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let green = Color(red: 143/255, green: 156/255, blue: 64/255)
    let background = Color(red: 255/255, green: 241/255, blue: 179/255)
    @ObservedObject var goalParser : GoalModelParser
    @State var allReadPages = 0
    @State var allReadSecond = 0
    @State var weekReadPages = 0
    @State var weekReadSecond = 0
    var body: some View {
        NavigationView{
                ZStack{
                    background
                        .edgesIgnoringSafeArea(.all)
                    if !ContentView().firstVisit(){
                        VStack{
                            Text("目標：")
                            Text("現在の状態：" )
                                .frame(width: 200, height: 100, alignment: .leading)
                                .padding(10)
                                Text(String(goalParser.model.num_pages))
                            ProgressView(value: progressAmount , total: Float(weekReadPages * 100 / goalParser.model.num_pages))
                                .progressViewStyle(LinearProgressViewStyle(tint: green))
                                .frame(width: UIScreen.main.bounds.width-50, height: 150, alignment: .center)
                                .foregroundColor(brown)
                                .font(.largeTitle)
                                .scaleEffect(x: 1, y: 4, anchor: .center)
                                .onReceive(timer, perform: { _ in
                                    if progressAmount < goalParser.model.progress {
                                        progressAmount = progressAmount + 1
                                    }else{
                                        timer.upstream.connect().cancel()
                                    }
                                })
                                
                        }
                    }else{
                        Text("目標はまだありません")
                    }
                }.navigationBarItems(trailing: NavigationLink( "目標登録", destination: GoalRegisterView(goalModelParser: goalParser)))
                .navigationTitle("目標")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .onAppear{
                    goalParser.decodeToGoalModel()
                    weekReadPages = goalParser.getReadPagesRequest()
                }
            }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(goalParser: GoalModelParser())
            .previewDevice("iPhone 11 Pro")
    }
}
