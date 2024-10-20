import CoreML
import Vision
import UIKit























class ObjectRecognizer {
    private var model_NetV2: VNCoreMLModel?
    private var model_YoloV3: VNCoreMLModel?

    init() {
        do {
            let configuration = MLModelConfiguration()
            
            
            let mlModel_NetV2 = try MobileNetV2(configuration: configuration).model
            model_NetV2 = try VNCoreMLModel(for: mlModel_NetV2)
            
            let mlModel = try YOLOv3(configuration: configuration).model
            model_YoloV3 = try VNCoreMLModel(for: mlModel)
            
        } catch {
            print("Failed to load model: \(error)")
        }
    }
    
    
    
    
    
    
    
    // MobileNetV2 识别
       func recognize_NetV2(image: UIImage, completion: @escaping (String?) -> Void) {
           guard let pixelBuffer = image.toCVPixelBuffer(), let model = model_NetV2 else {
               completion(nil)
               return
           }
           
           let request = VNCoreMLRequest(model: model) { (request, error) in
               if let results = request.results as? [VNClassificationObservation], let firstResult = results.first {
                   completion(firstResult.identifier)
               } else {
                   completion(nil)
               }
           }
           
           let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
           do {
               try handler.perform([request])
           } catch {
               print("Failed to perform request: \(error)")
               completion(nil)
           }
       }
    
    
    
    
    
    
    // YOLOv3 识别
       func recognize_YoloV3(image: UIImage, completion: @escaping ([String]?) -> Void) {
           guard let pixelBuffer = image.toCVPixelBuffer(), let model = model_YoloV3 else {
               completion(nil)
               return
           }

           let request = VNCoreMLRequest(model: model) { (request, error) in
               if let results = request.results as? [VNRecognizedObjectObservation] {
                   let detectedObjects = results.compactMap { observation -> String? in
                       observation.labels.first?.identifier
                   }
                   completion(detectedObjects)
               } else {
                   completion(nil)
               }
           }
           
           let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
           do {
               try handler.perform([request])
           } catch {
               print("Failed to perform request: \(error)")
               completion(nil)
           }
       }
    
    
    
    
    
    
    
    
    
    
    
    
}

// UIImage 转 CVPixelBuffer
extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let options: [CFString: Any] = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ]
        
        var pixelBuffer: CVPixelBuffer?
        let width = Int(size.width)
        let height = Int(size.height)
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, options as CFDictionary, &pixelBuffer)
        
        guard let unwrappedPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(unwrappedPixelBuffer, [])
        
        let pixelData = CVPixelBufferGetBaseAddress(unwrappedPixelBuffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(unwrappedPixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, [])
        
        return unwrappedPixelBuffer
    }
}
