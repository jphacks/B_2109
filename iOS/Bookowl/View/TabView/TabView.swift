//
//  TabView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/11/17.
//

import SwiftUI

struct TabsView: View {
    enum Tabs:String{
        case goal = "目標"
        case shelf = "本棚"
        case battle = "対戦相手"
    }
    
    enum Navs:String{
        case goalRegister = "目標登録"
        case bookRegister = "本登録"
    }

    @ObservedObject var goalParser : GoalModelParser
    @ObservedObject var bookAPI = BookAPI()
    
    @State private var navigationTitle: String = Tabs.goal.rawValue
       @State private var selectedTab: Tabs = .goal
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 241/255, blue: 179/255)
                .edgesIgnoringSafeArea(.all)
                TabView(selection: $selectedTab){
                    
                        TopView(goalParser: goalParser)
                            .tabItem{
    //                            VStack{
                                Text(Tabs.goal.rawValue)
    //                        }
                                
                        }.tag(Tabs.goal)
                    
                    
                        ShelfView()
                            .tabItem{
    //                            VStack{
                                Text(Tabs.shelf.rawValue)
    //                            }
                            }.tag(Tabs.shelf)
                    
                        ChooseBattleMember()
                            .tabItem{
                                Text(Tabs.battle.rawValue)
                            }.tag(Tabs.battle)
                }
        }
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}
// Iconの形式をそろえる
struct IconView: View {
    var systemName: String
    var body: some View {
        Image(systemName)
            .resizable()
            .font(.title)
            .frame(width: 50, height: 50, alignment: .leading)
    }
}
