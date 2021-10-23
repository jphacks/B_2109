//
//  ContentView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject private var isbnReader = ISBNReader()
    @ObservedObject var viewModel : ScannerViewModel

    var body: some View {
        
        ZStack {
            ISBNScannerView()
                .found(r: self.viewModel.onFoundQrCode)
                .interval(delay: self.viewModel.scanInterval)
            VStack {
                VStack {
                    Text("Keep scanning for QR-codes")
                        .font(.subheadline)

                    Text("QRコード読み取り結果 = [ " + self.viewModel.lastQrCode + " ]")
                        .bold()
                        .lineLimit(5)
                        .padding()

                    Button("Close") {
                        self.viewModel.isShowing = false
                    }
                }
                .padding(.vertical, 20)
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ScannerViewModel()
        ContentView(viewModel: model)
    }
}
