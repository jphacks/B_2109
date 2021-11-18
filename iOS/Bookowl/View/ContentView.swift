//
//  ContentView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import SwiftUI

struct CurrentUserDefaults{
    // 初回起動時判定
    static let isFirstVisit = "is_first_visit"
    static let goal = "goal"
}

struct ContentView: View {
    @State var isShowGoalSettingView = false
    @ObservedObject var goalParser = GoalModelParser()
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 241/255, blue: 179/255)
                .edgesIgnoringSafeArea(.all)
            if isShowGoalSettingView{
                GoalRegisterView(goalModelParser: goalParser)
            }else{
                TabsView(goalParser: goalParser)
            }
        
        }
        .onAppear(){
            self.firstVisit()
        }
    }
    
    
    func firstVisit()-> Bool{
        let visit = UserDefaults.standard.bool(forKey: CurrentUserDefaults.isFirstVisit)
        let goal =  UserDefaults.standard.bool(forKey: CurrentUserDefaults.goal)
        print(visit && goal)
                if visit && goal{
                    print("Access More Than Once")
                    goalParser.decodeToGoalModel()
//                    UserDefaults.standard.set(false, forKey: CurrentUserDefaults.isFirstVisit)
                    return false
                }else{
                    print("First Access")
                    DispatchQueue.main.async {
                        self.isShowGoalSettingView.toggle()
                    }
                    UserDefaults.standard.set(true, forKey: CurrentUserDefaults.isFirstVisit)
                    return true
                }
    }
    
//    func getDestination(from navItem: Navs) -> AnyView {
//        if navItem == Navs.goalRegister {
//            return AnyView(GoalRegisterView( goalModelParser: goalParser))
//        } else{
//            return AnyView(ISBNView())
//        }
//        
//    }
}


struct LoadingIndicatorView: View {
    let isLoading: Bool
    @State private var isAnimating = false
    private let animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isLoading{
                Color(.black)
                    .opacity(0.01)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .disabled(self.isLoading)
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.gray, .white]), center: .center),
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round,
                                dash: [0.1, 16],
                                dashPhase: 8))
                    .frame(width: 48, height: 48)
                    .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
                    .onAppear() {
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.isAnimating = true
                        }
                    }
                    .onDisappear() {
                        self.isAnimating = false
                    }
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
