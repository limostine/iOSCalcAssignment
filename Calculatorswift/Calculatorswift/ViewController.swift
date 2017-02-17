//
//  ViewController.swift
//  Calculatorswift
//
//  Created by ilabafrica on 30/01/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var display: UILabel!
    @IBOutlet  var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    let x = M_PI
    
    var brain = CalculatorModel()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(symbol: operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalIsPressed = false
        if let result = brain.pushOperand(operand: displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    var decimalIsPressed = false
    
    @IBAction func decimal() {
        userIsInTheMiddleOfTypingANumber = true
        if decimalIsPressed == false {
            display.text = display.text! + "."
            decimalIsPressed = true
        }
    }
    
    @IBAction func pi() {
        userIsInTheMiddleOfTypingANumber = true
        if display.text != "0.0" {
            enter()
            display.text = "\(x)"
            enter()
        } else {
            display.text = "\(x)"
            enter()
        }
    }
    
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        display.text = "0.0"
        brain.performClear()
    }
    
    
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
            
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }
    
}
