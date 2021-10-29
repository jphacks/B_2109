//
//  ISBNReader.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import Foundation
import Combine
import AVFoundation

class ISBNReader: NSObject, AVCaptureMetadataOutputObjectsDelegate ,  ObservableObject {
        var scanInterval: Double = 1.0
        var lastTime = Date(timeIntervalSince1970: 0)
        @Published var isbn : String = ""
        var onResult: (String) -> Void = { _  in }
        var mockData: String?
        @Published var isISBNFind : Bool = false
        
        override init() {
            super.init()
        }
    
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            for metadataObject in metadataObjects{
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                let prefixBarCode = stringValue.prefix(3)
//                読み取ったバーコードがISBNかどうかの判定。頭が978であればISBNとみなす。
                if prefixBarCode == "978"{
                    foundBarcode(stringValue)
                    isISBNFind = true
                    isbn = stringValue
                }
            }
            
        }

        @objc func onSimulateScanning(){
            foundBarcode(mockData ?? "Simulated QR-code result.")
        }

        func foundBarcode(_ stringValue: String) {
            let now = Date()
            if now.timeIntervalSince(lastTime) >= scanInterval {
                lastTime = now
                self.onResult(stringValue)
            }
        }
}
