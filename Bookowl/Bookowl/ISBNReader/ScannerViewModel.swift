//
//  ScannerViewModel.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import Foundation

class ScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0
    @Published var lastQrCode: String = "QRコード"
    @Published var isShowing: Bool = false

    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
        isShowing = false
    }
}
