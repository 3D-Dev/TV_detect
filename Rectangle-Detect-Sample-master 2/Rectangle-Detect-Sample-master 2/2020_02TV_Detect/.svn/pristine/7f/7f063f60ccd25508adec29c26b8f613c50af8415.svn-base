//
//  ViewController.swift
//  Object Tracking
//
//  Created by Alexey, Rubtsov (Russia) on 1/30/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    func crop( rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
    func addText(drawText text: String, atPoint point: CGPoint , FontSize size : CGFloat) -> UIImage {
        let textColor = UIColor(red: 255/255, green: 38/255, blue: 0, alpha: 0.35)
        let textFont = UIFont.systemFont(ofSize: size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor
            ] as [NSAttributedString.Key : Any]
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        
        let rect = CGRect(origin: point, size: self.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
}
