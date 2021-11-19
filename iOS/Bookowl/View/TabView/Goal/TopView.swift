//
//  TopView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/26.
//

import SwiftUI


struct TopView: View {
    @State var progressAmount : Float = 0.0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 0.01, on: .main, in: .common)
    let brown = Color(red: 105/255, green: 78/255, blue: 51/255)
    let green = Color(red: 143/255, green: 156/255, blue: 64/255)
    let background = Color(red: 255/255, green: 241/255, blue: 179/255)
    @ObservedObject var goalParser : GoalModelParser
    @ObservedObject var pieDataContainer = PieDataContainer()
    @State var allReadPages = 0
    @State var allReadSecond = 0
    @State var weekReadPages = 0
    @State var weekReadSecond = 0
    @State var pages = "10"
    @State var isPushed = false
    var body: some View {
        NavigationView{
                ZStack{
                    background
                        .edgesIgnoringSafeArea(.all)
//                    if !ContentView().firstVisit(){
                        VStack{
                            Spacer()
                            Text("今週の目標： " + String(goalParser.model.num_pages) + " ページ")
                                .font(.title2)
                                .foregroundColor(brown)
//                            PieChart(pieDataContainer: pieDataContainer)
                            Text("現在のページ数：" + String(weekReadPages) + "ページ" )
//                                .frame(width: 200, height: 100, alignment: .leading)
                                .padding(10)
                                .font(.headline)
                                .foregroundColor(brown)
                                
//
                            Text("達成度： "+String(Int(weekReadPages * 100 / Int(goalParser.model.num_pages)))+" %!!")
                                .font(.headline)
                                .foregroundColor(brown)
                            
                            ProgressView(value: Float(progressAmount) , total: 100)
                                .progressViewStyle(LinearProgressViewStyle(tint: green))
                                .frame(width: UIScreen.main.bounds.width-50, height: 30, alignment: .center)
                                .foregroundColor(brown)
                                .font(.title)
                                .scaleEffect(x: 1, y: 4, anchor: .center)
                                .onReceive(timer, perform: { _ in
                                    if progressAmount < goalParser.model.progress && progressAmount < 100{
                                        progressAmount += 1
                                    }else{
                                        cancelTimer()
                                        
                                    }
                                })
                            Spacer()
                            if Int(weekReadPages / Int(goalParser.model.num_pages)) < 1{
                                Text("目標達成まであと " + String(Int(goalParser.model.num_pages) - weekReadPages) + " ページ！！")
                                    .font(.headline)
                                    .foregroundColor(brown)
                                Text("毎日 " + String((Int(goalParser.model.num_pages) - weekReadPages) / goalParser.getDayCountBySunday() )  + "ページ読もう！！")
                                    .font(.headline)
                                    .foregroundColor(brown)
                                Spacer()
                            }else{
                                Text("目標達成！！\n来週も続けよう！")
                                    .font(.headline)
                                    .foregroundColor(brown)
                                    
                                Spacer()
                            }
                                
                        }
                    TextFieldAlertView(text: $pages, isShowingAlert: $isPushed, placeholder: "", isSecureTextEntry: false, title: "目標を入力してください。", message: "一週間で読むページ数を入力してください。", leftButtonTitle: "キャンセル", rightButtonTitle: "決定", leftButtonAction: nil, rightButtonAction: {
                            let page = Int($pages.wrappedValue)
                            goalParser.RegisterGoalRequest(pages: Int64(page!))
                        goalParser.model.progress = Float(weekReadPages*100 / Int(page!))
                        progressAmount = 0
                        instantiateTimer()
                        self.timer.connect()
                        isPushed = false
                            
                        
                    })
                }.navigationBarItems(trailing: Button(action: {
                    isPushed = true
                }){
                    Text("目標登録")
                } )
                    .navigationTitle("目標")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(StackNavigationViewStyle())
//            else{
//                        Text("目標はまだありません")
//                    }
                }
                .onAppear{
                    timer.connect()
                    print("Top appear!!")
                    goalParser.decodeToGoalModel()
                    weekReadPages = goalParser.getReadPagesRequest()
                    pages = String(goalParser.model.num_pages)
                    print(weekReadPages)
                    let percentage = CGFloat(weekReadPages*100/Int(goalParser.model.num_pages))
                    print("percentage")
                    print(percentage)
//                    pieDataContainer.setPieData(pieData: [PieData(color: red, percent: min(100,percentage) , value: 0), PieData(color: .gray, percent: max(100 - percentage,0) , value: 0)])
                }
            }
    
    func instantiateTimer() {
        self.timer = Timer.publish (every: 0.01, on: .main, in: .common)
        return
    }
    func cancelTimer() {
            self.timer.connect().cancel()
            return
        }
    
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(goalParser: GoalModelParser())
            .previewDevice("iPhone X")
    }
}
