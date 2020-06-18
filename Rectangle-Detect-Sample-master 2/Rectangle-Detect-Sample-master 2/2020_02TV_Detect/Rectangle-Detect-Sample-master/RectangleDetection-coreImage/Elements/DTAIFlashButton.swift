//
//  ViewController.swift
//  Object Tracking
//
//  Created by Alexey, Rubtsov (Russia) on 1/30/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class DTAIFlashButton: UIButton {

    var isOn = false
    
    override func awakeFromNib() {
        self.setImage(UIImage(named: "flashOff"), for: .normal)
        self.addTarget(self, action: #selector(DTAIFlashButton.buttonClicked(_:)), for: .touchUpInside)
    }

    @objc func buttonClicked(_ sender: UIButton) {
        self.isOn = !self.isOn
        if isOn
        {
            self.setImage(UIImage(named: "flashOn"), for: .normal)
        }
        else
        {            
            self.setImage(UIImage(named: "flashOff"), for: .normal)
        }
    }
}
