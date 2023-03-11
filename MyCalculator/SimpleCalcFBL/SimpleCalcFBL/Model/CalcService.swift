//
//  CalcService.swift
//  SimpleCalcFBL
//
//  Created by OneClick on 8/3/23.
//

import Foundation

class CalcService {
    // MARK: Properties
    let displayView: ViewController
    var currentOperation = Operations.noAction
    var currentNumber    = "0"
    var firstNumber      = 0.0
    var secondNumber     = 0.0
    var isDouble         = false
    var result           = ""
    
    init(displayView: ViewController) {
        self.displayView = displayView
    }
    
    func status() {
        print(
            """
            current number = \(currentNumber)
            first = \(firstNumber)
            second = \(secondNumber)
            result = \(result)
            """
        )
    }
    
    func acAction() {
        firstNumber = 0.0
        secondNumber = 0.0
        currentOperation = .noAction
        currentNumber = ""
        result = ""
        displayView.updateDisplay(text: currentNumber)
        status()
        displayView.updateDisplay(text: "0")
    }
    func makeCalculation(operation: Operations) {
        if currentOperation != .noAction {
            
            if currentNumber != "" {
                secondNumber = Double(currentNumber)!
                
                switch operation {
                case .noAction:
                    print("No action")
                case .addition:
                    result = String(firstNumber + secondNumber)
                case .substraction:
                    result = String(firstNumber - secondNumber)
                case .division:
                    result = String(firstNumber / secondNumber)
                case .multiplication:
                    result = String(firstNumber * secondNumber)
                }
                
                firstNumber = Double(result)!
                
                if Double(result)!.truncatingRemainder(dividingBy: 1) == 0 {
                    result = String(Int(Double(result)!))
                }
                currentNumber = result
                displayView.updateDisplay(text: currentNumber)
                currentOperation = .noAction
            }

        } else {
            firstNumber = Double(currentNumber) ?? 0.0
            currentNumber = ""
            displayView.updateDisplay(text: "")
            currentOperation = operation
        }
        
        status()

    }
    func changeSign() {
        var temp = currentNumber
        if temp.contains("-") {
            let sign = ["-"]
            temp = String(temp.filter { !sign.contains(String($0)) })
            print(temp)
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        } else {
            temp = "-" + currentNumber
            print(temp)
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        }
    }
    func percent() {
        currentNumber = String(Double(currentNumber)! / 100)
        displayView.updateDisplay(text: currentNumber)
        result = currentNumber
        firstNumber = Double(result)!
    }
    func division() {
        makeCalculation(operation: .division)
    }
    func multiplication() {
        makeCalculation(operation: .multiplication)
    }
    func substraction() {
        if (currentNumber == "0") || (currentNumber == "") {
            currentNumber = "-"
            displayView.updateDisplay(text: currentNumber)
        } else {
            makeCalculation(operation: .substraction)
        }
    }
    func addition() {
        makeCalculation(operation: .addition)
    }
    func makeResult() {
        makeCalculation(operation: currentOperation)
    }
    func dot() {
        if currentNumber.contains(".") {
            return
        } else {
            currentNumber += "."
            displayView.updateDisplay(text: currentNumber)
        }
    }
    func numberAction(number: Int) {
        if currentNumber != "0" {
            currentNumber.append(String(number))
            displayView.updateDisplay(text: currentNumber)
        } else {
            currentNumber = String(number)
            displayView.updateDisplay(text: currentNumber)
        }
    }
    func removeCharacter() {
        currentNumber.removeLast()
        displayView.updateDisplay(text: currentNumber)
    }
}
