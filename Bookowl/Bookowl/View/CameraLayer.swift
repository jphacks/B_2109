//
//  CameraLayer.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import SwiftUI
import AVFoundation

class CameraLayer : UIView {
    private var label:UILabel?

    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var reader : ISBNReader?

       init(session: AVCaptureSession) {
           super.init(frame: .zero)
           self.session = session
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       @objc func onClick(){
           reader?.onSimulateScanning()
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           previewLayer?.frame = self.bounds
       }

    }
