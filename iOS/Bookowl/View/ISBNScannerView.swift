//
//  ISBNScannerView.swift
//  Bookowl
//
//  Created by ayano-ik on 2021/10/23.
//

import SwiftUI
import AVFoundation
struct ISBNScannerView:  UIViewRepresentable {
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.ean8,.ean13]
        typealias UIViewType = CameraLayer

        private let session = AVCaptureSession()
        private let reader = ISBNReader()
        private let metadataOutput = AVCaptureMetadataOutput()

        func interval(delay: Double) -> ISBNScannerView {
            reader.scanInterval = delay
            return self
        }

        func found(r: @escaping (String) -> Void) -> ISBNScannerView {
            print("found")
            reader.onResult = r
            print(r)
            return self
        }

        func setupCamera(_ uiView: CameraLayer) {
            if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
                if let input = try? AVCaptureDeviceInput(device: backCamera) {
                    session.sessionPreset = .photo

                    if session.canAddInput(input) {
                        session.addInput(input)
                    }
                    if session.canAddOutput(metadataOutput) {
                        session.addOutput(metadataOutput)

                        metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                        metadataOutput.setMetadataObjectsDelegate(reader, queue: DispatchQueue.main)
                    }
                    let previewLayer = AVCaptureVideoPreviewLayer(session: session)

                    uiView.backgroundColor = UIColor.gray
                    previewLayer.videoGravity = .resizeAspectFill
                    uiView.layer.addSublayer(previewLayer)
                    uiView.previewLayer = previewLayer

                    session.startRunning()
                }
            }

        }

        func makeUIView(context: UIViewRepresentableContext<ISBNScannerView>) -> ISBNScannerView.UIViewType {
            let cameraView = CameraLayer(session: session)
            checkCameraAuthorizationStatus(cameraView)

            return cameraView
        }

        static func dismantleUIView(_ uiView: CameraLayer, coordinator: ()) {
            uiView.session.stopRunning()
        }

        private func checkCameraAuthorizationStatus(_ uiView: CameraLayer) {
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if cameraAuthorizationStatus == .authorized {
                setupCamera(uiView)
            } else {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.sync {
                        if granted {
                            self.setupCamera(uiView)
                        }
                    }
                }
            }
        }

        func updateUIView(_ uiView: CameraLayer, context: UIViewRepresentableContext<ISBNScannerView>) {
            uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        }

}

struct ISBNScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ISBNScannerView()
    }
}
