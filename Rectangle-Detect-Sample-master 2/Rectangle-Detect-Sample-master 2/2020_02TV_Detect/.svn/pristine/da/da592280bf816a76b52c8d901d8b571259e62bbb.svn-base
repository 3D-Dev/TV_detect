//
//  ViewController.swift
//  Object Tracking
//
//  Created by Alexey, Rubtsov (Russia) on 1/30/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit
extension CGPoint {
    
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width, y: self.y * size.height)
    }
    
    func scaleToSize(to size:DTAICorpScale) ->CGPoint
    {
        
        let tansfer = CGAffineTransform(scaleX: size.scaleX!, y: size.scaleY!)
        
        return self.applying(tansfer)
    }
    
    //MARK : Switch to Cartesian coordinate system
    func cartesianForPoint(extent:CGSize) -> CGPoint {
        return CGPoint(x: self.x,y: extent.height - self.y)
    }
}
