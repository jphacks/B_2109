//
//  PieChart.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/20.
//

import SwiftUI
struct PieData{
    var id = UUID()
        var color : Color
        var percent : CGFloat
        var value : CGFloat
}

class PieDataContainer : ObservableObject{
//    @Published var chartData =
//            [PiwData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 8, value: 0),
//             CrtData(color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 15, value: 0),
//             ChartData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 32, value: 0),
//             ChartData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 45, value: 0)]
//    PieData(color: red, percent: 0, value: 0)
    @Published var pieData = [PieData(color: red, percent: 0, value: 0), PieData(color: .gray, percent: 100, value: 0)]
        //    init() {
        //        calc()
        //    }
    
    func setPieData(pieData:[PieData]){
        self.pieData = pieData
        calc()
    }
        func calc(){
            var value : CGFloat = 0
            for i in 0..<pieData.count {
                value += pieData[i].percent
                pieData[i].value = value
            }
        }
}

struct PieChart: View {
    @ObservedObject var pieDataContainer : PieDataContainer
    var body: some View {
        VStack {
                    //MARK:- Pie Slices
            ZStack {
                ForEach(0..<pieDataContainer.pieData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : pieDataContainer.pieData[index-1].value/100,
                              to: pieDataContainer.pieData[index].value/100)
                        .stroke(pieDataContainer.pieData[index].color,lineWidth: 50)
                        .scaleEffect(1.0)
                        .animation(.spring())
                }
//                常に目標に対する読んだページの割合を示す
                Text(String(format: "%.2f", Double(pieDataContainer.pieData[0].percent))+"%")
                    .font(.title)
            }
        }
        .frame(width: 200, height: 250)
        .padding()
        .onAppear() {
            self.pieDataContainer.calc()
        }
    }
}



struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(pieDataContainer: PieDataContainer())
    }
}
