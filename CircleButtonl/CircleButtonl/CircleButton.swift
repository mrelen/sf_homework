//
//  CircleButton.swift
//  CircleButtonl
//
//  Created by OneClick on 26/5/23.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    
}
