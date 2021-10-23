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

        var onResult: (String) -> Void = { _  in }
        var mockData: String?

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            for metadataObject in metadataObjects{
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                let prefixBarCode = stringValue.prefix(3)
                if prefixBarCode == "978"{
                    foundBarcode(stringValue)
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
