//
//  CustomSegment.swift
//  СustomController
//
//  Created by OneClick on 31/5/23.
//

import Foundation
import UIKit

class CustomSegment: UIControl {
    
    var labels = [UILabel]()
    var simpleView = UIView()
    var items: [String] = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            if items.count > 0 {
                setLabels ()
            }
        }
    }
        var selectedIndex: Int = 0 {
            didSet {
                showNewSelectedIndex()
            }
        }
    
    @IBInspectable var selectedLabelColor: UIColor = UIColor.darkGray {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable var unselectedLabelColor: UIColor = UIColor.white {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable var thumbColor: UIColor = UIColor.white {
        didSet { setSelectedColors() }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    var font: UIFont? = UIFont.systemFont (ofSize: 12) {
        didSet { setFont() }
    }
    
    var padding: CGFloat = 0 {
        didSet { setLabels() }
    }
    
    override init(frame: CGRect){
        super.init (frame: frame)
        setView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.4).cgColor
        layer.borderWidth = 2
        
        backgroundColor = UIColor.clear
        
        setLabels()
        
        insertSubview(simpleView, at: 0)
    }
    
    func setLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index - 1]
            label.textAlignment = .center
    
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            
            label.backgroundColor = .clear
            
            label.font = font
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(label)
    

        

        

                
           
            //UIColor(white: 0.4, alpha: 1.0)
                self.addSubview(label)
                labels.append(label)
            }
        }
        func showNewSelectedIndex () {
            var label = labels[selectedIndex]
            self.simpleView.frame = label.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if labels.count > 0 {
            let label = labels[selectedIndex]
            label.textColor = selectedLabelColor
            simpleView.frame = label.frame
            simpleView.backgroundColor = thumbColor
            simpleView.layer.cornerRadius = simpleView.frame. height / 2
            showNewSelectedIndex()
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex: Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func setSelectedColors() {
        for item in labels {
            item.textColor = unselectedLabelColor
        }
        
        if labels.count > 0 {
            labels[0].textColor = selectedLabelColor
        }
        
        simpleView.backgroundColor = thumbColor
    }
    
    func setFont() {
        for item in labels {
            item.font = font
        }
    }
}
