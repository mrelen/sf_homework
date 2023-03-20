//
//  ViewController.swift
//  Calc5
//
//  Created by OneClick on 13/3/23.
//

import UIKit



class ViewController: UIViewController {
    
    
    // переменные для операций и результат
    var firstNumber: String = "" {
        willSet {
          print(newValue)
        }
      }
    var operation: String = ""
    var secondNumber: String = ""
    var haveResult: Bool = false
    var resultNumber: String = ""
    var numAfterResult: String = ""
    
    
    @IBAction func negative(_ sender: Any) {
        if operation.isEmpty {
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
        operation = "%"
    }
    
    @IBAction func add(_ sender: Any) {
        operation = "+"
    }
    @IBAction func subtract(_ sender: Any) {
        operation = "-"
    }
    @IBAction func multiply(_ sender: Any) {
        operation = "×"
    }
    
    @IBAction func divide(_ sender: Any) {
        operation = "÷"
    }
    
    @IBAction func dot(_ sender: Any) {
        
        // точка
        if operation.isEmpty {
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
        
        let numArray = resultNumber.components(separatedBy: ".")
        if numArray[1] == "0" {
            numOnScreen.text = numArray[0]
        } else {
            numOnScreen.text = resultNumber
        }
        // максимальное число результата или count = 14 (четырнадцатизначное четное число)
        if let result = Double(resultNumber), result > 99_999_999_999_999 { //99 триллионов
            numOnScreen.text = "0"
        }
    }
    
    
    // строка ввода
    @IBOutlet weak var numOnScreen: UILabel!
    
    //кнопочки умножения, деления, вычитания, процнт и прочее
    @IBOutlet var calcButtons: [UIButton]!
    
    // кнопочки от 0 до 9, кроме .
    @IBAction func numPressed(_ sender: UIButton) {
        
        // вводим первое число, которое не больше 14 символов, иначе =0
        if operation == "" {
            firstNumber += String(sender.tag)
            if firstNumber.count > 14 {
                firstNumber = ""
                    operation = ""
                    secondNumber = ""
                    haveResult = false
                    resultNumber = ""
                    numAfterResult = ""
                numOnScreen.text = "0"
            } else {
                numOnScreen.text = firstNumber
            }
        }
        
        // вводим второе число, которое не превышает 14 символов, иначе =0
        else if operation != "" && !haveResult {
            secondNumber += String(sender.tag)
            if secondNumber.count > 14 {
                secondNumber = ""
                    operation = ""
                    firstNumber = ""
                    haveResult = false
                    resultNumber = ""
                    numAfterResult = ""
                numOnScreen.text = "0"
            } else {
                numOnScreen.text = secondNumber
            }
        }
    }
    
    

    // сброс до 0 (кнопка А/С)
    @IBAction func clear(_ sender: Any) {
        firstNumber = ""
        operation = ""
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
    
    // код еще в проекте, т.к. nil после первой операции, например 2 + 2 = 4 + 1 = nil
    func doOperation() -> Double {
        if operation == "%" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! / 100 * Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! / 100 * Double(numAfterResult)!
            }
        }
        if operation == "+" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! + Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! + Double(numAfterResult)!
            }
        }
        
        else if operation == "-" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! - Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! - Double(numAfterResult)!
            }
        }
        else if operation == "×" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! * Double(secondNumber)!
            }
            else {
                return Double(resultNumber)! * Double(numAfterResult)!
            }
        }
        else if operation == "÷" {
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

