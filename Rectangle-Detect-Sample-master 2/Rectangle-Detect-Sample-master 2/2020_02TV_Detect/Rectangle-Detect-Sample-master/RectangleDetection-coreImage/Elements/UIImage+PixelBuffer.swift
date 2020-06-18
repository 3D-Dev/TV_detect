//
//  UIImage+PixelBuffer.swift
//  Food101Prediction
//
//  Created by Philipp Gabriel on 15.02.18.
//  Copyright © 2018 Philipp Gabriel. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    public func pixelData() -> [UInt8]? {
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return pixelData
    }
    
    /*
    func preprocess(image: UIImage) -> MLMultiArray? {
        let size = CGSize(width: 128, height: 128)
        
        
        guard let pixels = image.resize(to: size).pixelData()?.map({ (Double($0) / 255.0 )  }) else {
            return nil
        }
        
        guard let array = try? MLMultiArray(shape: [3, 128, 128], dataType: .double) else {
            return nil
        }
        
        let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
        let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
        let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
        
        let combination = r + g + b
        for (index, element) in combination.enumerated() {
            array[index] = NSNumber(value: element)
        }
        
        return array
    }*/
    
    func imageToCVPPixelBuffer() ->CVPixelBuffer?
    {    
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    //MARK: Picture pre-processing
    func imagePreprocess() -> UIImage?
    {
        
        //Step1
        //Scale images by ratio
        let frameSize = size
        let maxRatio =  128 /  max(frameSize.width, frameSize.height)
       
        let newWidth = frameSize.width * maxRatio
        let newHeight = frameSize.height * maxRatio
              
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImageSize =    UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Step2
        //128 * 128
        UIGraphicsBeginImageContextWithOptions(    CGSize(width: 128, height: 128), true, 0)
        UIColor.black.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 128, height: 128))
        let bgBlackImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        //96 120

        UIGraphicsBeginImageContextWithOptions(   bgBlackImg.size, true, 0)
        
        let centerX = (128 - newWidth)/2
        let centerY = (128 - newHeight)/2
        bgBlackImg.draw(in: CGRect(x: 0, y: 0, width: bgBlackImg.size.width, height: bgBlackImg.size.height))
        
        newImageSize.draw(in: CGRect(x: centerX, y: centerY, width: newImageSize.size.width, height: newImageSize.size.height))
        
        let combineImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return combineImg
        
        
    }
    
}
