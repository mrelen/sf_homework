//
//  ViewController.swift
//  Calc5
//
//  Created by OneClick on 13/3/23.
//

import UIKit


// переменные для операций и результат
class ViewController: UIViewController {
    
    var firstNumber: String = "" {
        willSet {
          print(newValue)
        }
      }
    var operatoin: String = ""
    var secondNumber: String = ""
    var haveResult: Bool = false
    var resultNumber: String = ""
    var numAfterResult: String = ""
    
    
    @IBAction func negative(_ sender: Any) {
        if operatoin.isEmpty {
            if firstNumber.starts(with: "-") {
                firstNumber = String (firstNumber.dropFirst())
            } else {
                firstNumber = "-" + firstNumber
               
            }
            numOnScreen.text = firstNumber
        } else {
            if firstNumber.starts(with: "") {
                firstNumber = String (firstNumber.dropFirst())
            } else {
                firstNumber = "" + firstNumber
               
            }
            numOnScreen.text = firstNumber
        }
    }
    
    @IBAction func percent(_ sender: Any) {
        operatoin = "%"
    }
    
    @IBAction func add(_ sender: Any) {
        operatoin = "+"
    }
    @IBAction func subtract(_ sender: Any) {
        operatoin = "-"
    }
    @IBAction func multiply(_ sender: Any) {
        operatoin = "×"
    }
    
    @IBAction func divide(_ sender: Any) {
        operatoin = "÷"
    }
    
    @IBAction func dot(_ sender: Any) {
        
        // запятая
        if operatoin.isEmpty {
            if Double(firstNumber + ".") != nil {
                firstNumber += String(".")
                numOnScreen.text = firstNumber
            }
        } else {
            if Double(secondNumber + ".") != nil {
                secondNumber += String(".")
                numOnScreen.text = secondNumber
            }
        }
    }
       
    
    @IBAction func equals(_ sender: Any) {
        resultNumber = String(doOperation())
        numAfterResult = ""
        
        // показывать целое число, если после .0
        let numArray = resultNumber.components(separatedBy: ".")
        print(numArray)
        if numArray[1] == "0" {
            numOnScreen.text = numArray[0]
        }
        // показывать десятичное число
        else {
            numOnScreen.text = resultNumber
        }
    }
    
    
    // строка ввода
    @IBOutlet weak var numOnScreen: UILabel!
    
    //кнопочки умножения, деления, вычитания, процнт и прочее
    @IBOutlet var calcButtons: [UIButton]!
    
    // кнопочки от 0 до 9, кроме .
    @IBAction func numPressed(_ sender: UIButton) {
        // вводим первое число
        if operatoin == "" {
            firstNumber += String(sender.tag)
            numOnScreen.text = firstNumber
        } else if operatoin != "" && !haveResult {
            // вводим второе число
            secondNumber += String(sender.tag)
            numOnScreen.text = secondNumber
        }
        else if operatoin != "" && haveResult {
            numAfterResult += String(sender.tag)
            numOnScreen.text = numAfterResult
        }
        
    }
    
    
    // сброс до 0 (кнопка А/С)
    @IBAction func clear(_ sender: Any) {
        firstNumber = ""
        operatoin = ""
        secondNumber = ""
        haveResult = false
        resultNumber = ""
        numAfterResult = ""
        numOnScreen.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // дизайн кнопочек
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.size.height / 2 ;
            button.titleLabel?.font = UIFont (name: "System", size: 24)
            button.layer.shadowColor = UIColor.systemPink.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 9)
            button.layer.shadowRadius = 8
            button.layer.shadowOpacity = 1
            
            
        }
        
    }
    
    func doOperation() -> Double {
        if operatoin == "%" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! / 100 * Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! / 100 * Double(numAfterResult)!
            }
        }
        if operatoin == "+" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! + Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! + Double(numAfterResult)!
            }
        }
        
        else if operatoin == "-" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! - Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! - Double(numAfterResult)!
            }
        }
        else if operatoin == "×" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! * Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! * Double(numAfterResult)!
            }
        }
        else if operatoin == "÷" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! / Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! / Double(numAfterResult)!
            }
        }
        
        return 0
    }
}

