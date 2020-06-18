//
//  ViewController.swift
//  Object Tracking
//
//  Created by Alexey, Rubtsov (Russia) on 1/30/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class camButton : UIButton{
    
    @IBInspectable var borderColor : UIColor {
        get{
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set{
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
}
