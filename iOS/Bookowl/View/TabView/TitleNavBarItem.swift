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
let unselectedColor = Color(red: 250/255.0, green: 187/255.0, blue: 118/255.0, opacity: 1.0)
let selectedColor = Color(red: 169/255.0, green: 49/255.0, blue: 48/255.0, opacity: 0.7)
let brownColor = Color(red: 105/255.0, green: 78/255.0, blue: 51/255.0, opacity: 1.0)

let background = Color(red: 255/255, green: 241/255, blue: 179/255,opacity: 1.0)

private class ButtonTheme: ObservableObject {
    @Published var backgroundColor = background
    @Published var textColor = Color.gray
}

struct TitleNavBarItem: View, PagerTabViewDelegate {
    let title: String
    
    @ObservedObject fileprivate var theme = ButtonTheme()
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(theme.textColor)
                .font(.body)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.backgroundColor)
    }
    
    func setState(state: PagerTabViewState) {
        switch state {
        case .selected:
            self.theme.textColor = brownColor
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
