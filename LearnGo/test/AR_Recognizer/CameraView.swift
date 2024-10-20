import SwiftUI
import AVFoundation
import CoreML

struct CameraView: UIViewControllerRepresentable {
    @Binding var recognizedObject: String?
    @Binding var isCameraActive: Bool

    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        if isCameraActive {
            DispatchQueue.global(qos: .background).async {
                uiViewController.startSession()
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                uiViewController.stopSession()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CameraViewControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func didRecognizeObject(_ object: String) {
            DispatchQueue.main.async {
                self.parent.recognizedObject = object
            }
        }
    }
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var delegate: CameraViewControllerDelegate?
    let model = MobileNetV2() // 确保你已添加模型

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        setupCamera()
    }
    
    func setupCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
    }
    
    func startSession() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // 运行物体识别
        guard let prediction = try? model.prediction(image: pixelBuffer) else { return }
        let recognizedObject = prediction.classLabel
        
        DispatchQueue.main.async {
            self.delegate?.didRecognizeObject(recognizedObject)
        }
    }
}

protocol CameraViewControllerDelegate {
    func didRecognizeObject(_ object: String)
}
