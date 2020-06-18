//
//  ViewController.swift
//  Object Tracking
//
//  Created by Alexey, Rubtsov (Russia) on 1/30/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class DTAICameraSlider: UISlider {

    
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.origin.x, y: bounds.size.height/2)
        
        
        let customBounds = CGRect(origin: point, size: CGSize(width: bounds.size.width, height: 4.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }

}
