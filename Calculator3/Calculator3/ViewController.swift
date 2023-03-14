//
//  ViewController.swift
//  Calculator3
//
//  Created by OneClick on 11/3/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    
    var previousValue = 0.0
    var currentOperation = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let number = sender.titleLabel?.text ?? ""
        displayLabel.text = displayLabel.text! + number
    }
    
    @IBAction func operationButtonTapped(_ sender: UIButton) {
        let operation = sender.titleLabel?.text ?? ""
        previousValue = Double(displayLabel.text ?? "") ?? 0.0
        currentOperation = operation
        displayLabel.text = ""
    }
    
    @IBAction func equalsButtonTapped(_ sender: UIButton) {
        let currentValue = Double(displayLabel.text ?? "") ?? 0.0
        var result = 0.0
        
        switch currentOperation {
        case "+":
            result = previousValue + currentValue
        case "-":
            result = previousValue - currentValue
        case "×":
            result = previousValue * currentValue
        case "÷":
            result = previousValue / currentValue
        default:
            break
        }
        
        displayLabel.text = String(result)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        displayLabel.text = ""
        previousValue = 0.0
        currentOperation = ""
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


