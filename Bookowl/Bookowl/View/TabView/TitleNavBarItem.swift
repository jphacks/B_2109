//
//  TitleNavBarItem.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/27.
//
import Combine
import SwiftUI
import PagerTabStripView


let redColor = Color(red: 221/255.0, green: 0/255.0, blue: 19/255.0, opacity: 1.0)
let unselectedColor = Color(red: 73/255.0, green: 8/255.0, blue: 10/255.0, opacity: 1.0)
let selectedColor = Color(red: 234/255.0, green: 234/255.0, blue: 234/255.0, opacity: 0.7)

private class ButtonTheme: ObservableObject {
    @Published var backgroundColor = redColor
    @Published var textColor = unselectedColor
}

struct TitleNavBarItem: View, PagerTabViewDelegate {
    let title: String
    
    @ObservedObject fileprivate var theme = ButtonTheme()
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(theme.textColor)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    func setState(state: PagerTabViewState) {
        switch state {
        case .selected:
            self.theme.textColor = .blue
        default:
            self.theme.textColor = .gray
        }
    }
}

struct TitleNavBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TitleNavBarItem(title: "Home")
    }
}
