//
//  MyCustomView.swift
//  MyCustomViewProject
//
//  Created by OneClick on 24/5/23.
//

import UIKit

@IBDesignable class MyCustomView: UIView {

    @IBOutlet weak var labelForView: UILabel!
    
    @IBInspectable var labelText: String {
        get {
            return labelForView.text!
        }
            set (labelText) {
                labelForView.text = labelText
            }
        }
    var workingView: UIView!
    var xibName: String =
    "MyCustomView"
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        setCustomView()
    }
    
    required init? (coder: NSCoder) {
    super.init (coder: coder)
        setCustomView()
    }
    
    func getFromXib() -> UIView {
    let bundle = Bundle (for: type(of: self))
    let xib = UINib (nibName: xibName, bundle: bundle)
    let view = xib.instantiate (withOwner: self, options: nil).first as! UIView
    return view
    }
    
    func setCustomView() {
        workingView = getFromXib ()
        workingView.frame = bounds
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview (workingView)
    }

                /*
                 // Only override draw() if you perform custom drawing.
                 // An empty implementation adversely affects performance during animation.
                 override func draw(_ rect: CGRect) {
                 // Drawing code
                 }
                 */
                
            }
        
