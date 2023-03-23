//
// ViewController.swift
// Calc5
//
// Created by OneClick on 13/3/23.
//

import UIKit


class ViewController: UIViewController {
    
// переменные для операций
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
    
   // минус перед числом
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
    
   // точка
  @IBAction func dot(_ sender: Any) {
    
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
        
        // использовать результат предыдущей операции в качестве первого числа
        var num1 = firstNumber
        if haveResult {
            num1 = resultNumber
        }
        
        // посчитать результат
        let num2 = secondNumber
        let result = doOperation(num1: num1, num2: num2, operation: operation)
        
        // показать результат
        resultNumber = String(result)
        numAfterResult = ""
        let numArray = resultNumber.components(separatedBy: ".")
        if numArray[1] == "0" {
            numOnScreen.text = numArray[0]
        } else {
            numOnScreen.text = resultNumber
        }
        
        // переменные для следующей операции и значение true, указывает, что есть результат, который можно использовать в качестве первого числа, что замыкает цикл, который будет работать бесконечно, пока не будет нажата кнопка очистки
        firstNumber = resultNumber
        secondNumber = ""
        operation = ""
        haveResult = true
        
        // максимальный результат - 99 триллионов
        if let result = Double(resultNumber), result > 99_999_999_999_999 {
            numOnScreen.text = "0"
        }
    }
    
  // строка ввода
  @IBOutlet weak var numOnScreen: UILabel!
  //кнопочки умножения, деления, вычитания, процнт и прочее
  @IBOutlet var calcButtons: [UIButton]!
  // кнопочки от 0 до 9, кроме .
    @IBAction func numPressed(_ sender: UIButton) {
        
        // также использовать результат предыдущей операции в качестве первого числа
        if haveResult {
            firstNumber = resultNumber
            haveResult = false
        }
        
        // вводим первое число, оно не должно превышать 14 символов, иначе =0
        if operation == "" {
            firstNumber += String(sender.tag)
            if firstNumber.count > 14 {
                clear(self)
            } else {
                numOnScreen.text = firstNumber
            }
        // вводим второе число не более 14 символов, иначе =0
        } else {
            secondNumber += String(sender.tag)
            if secondNumber.count > 14 {
                clear(self)
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
    
    // производим арифметические операции
    func doOperation(num1: String, num2: String, operation: String) -> Double {
        var result = 0.0
        
        if operation == "%" {
            result = Double(num1)! / 100.0 * Double(num2)!
        } else if operation == "+" {
            result = Double(num1)! + Double(num2)!
        } else if operation == "-" {
            result = Double(num1)! - Double(num2)!
        } else if operation == "×" {
            result = Double(num1)! * Double(num2)!
        } else if operation == "÷" {
            if num2 != "" && Double(num2)! != 0 {
                result = Double(num1)! / Double(num2)!
            } else {
                result = 0
            }
        }
        
        return result
    }
}
