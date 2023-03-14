//
//  ViewController.swift
//  Calc5
//
//  Created by OneClick on 13/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNumber: String = ""
    var operatoin: String = ""
    var secondNumber: String = ""
    var haveResult: Bool = false
    var resultNumber: String = ""
    var numAfterResult: String = ""
    

    @IBOutlet weak var numOnScreen: UILabel!
    
    @IBOutlet var calcButtons: [UIButton]!
    
    @IBAction func numPressed(_ sender: UIButton) {
        if operatoin == "" {
            firstNumber += String(sender.tag)
            numOnScreen.text = firstNumber
        } else if operatoin != "" && !haveResult {
            firstNumber += String(sender.tag)
            numOnScreen.text = secondNumber
        }

    }
    
    
    @IBAction func clear(_ sender: Any) {
        firstNumber = ""
        operatoin = ""
        secondNumber = ""
        haveResult = false
        resultNumber = ""
        numAfterResult = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.size.height / 2 ;
            button.titleLabel?.font = UIFont (name: "System", size: 24)
            button.layer.shadowColor = UIColor.systemPink.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 9)
            button.layer.shadowRadius = 8
            button.layer.shadowOpacity = 1
            

        }
        
    }


}

