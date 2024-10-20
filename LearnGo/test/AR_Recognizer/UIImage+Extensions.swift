//import UIKit
//import CoreVideo
//
//extension UIImage {
//    func toCVPixelBuffer() -> CVPixelBuffer? {
//        let attrs = [
//            kCVPixelBufferCGImageCompatibilityKey: true,
//            kCVPixelBufferCGBitmapContextCompatibilityKey: true
//        ] as CFDictionary
//
//        var pixelBuffer: CVPixelBuffer?
//        let width = Int(self.size.width)
//        let height = Int(self.size.height)
//
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          width,
//                                          height,
//                                          kCVPixelFormatType_32ARGB,
//                                          attrs,
//                                          &pixelBuffer)
//
//        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
//            return nil
//        }
//
//        CVPixelBufferLockBaseAddress(buffer, [])
//
//        let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
//                                width: width,
//                                height: height,
//                                bitsPerComponent: 8,
//                                bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
//                                space: CGColorSpaceCreateDeviceRGB(),
//                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//
//        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        CVPixelBufferUnlockBaseAddress(buffer, [])
//
//        return buffer
//    }
//}
