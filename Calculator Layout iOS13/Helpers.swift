//
//  Helpers.swift
//  Calculator Layout iOS13
//
//  Created by Harun Fazlic on 9. 9. 2022..
//  Copyright © 2022 The App Brewery. All rights reserved.
//


import UIKit
import Foundation

extension ViewController {
    
    func contain(x: Double, op: String, y: Double){
        if (y == 0.0 || y == 0) && op == "/"{
            
            ViewController.equalDeduplicator = false
            ViewController.equalSetter = false
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.numCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
            // ViewController.controller1 = 0
            ViewController.isNumLastPressed = false
            resultLabel.text = "undefined"
            
        } else {
            let expression = NSExpression(format: "\(x)\(op)\(y)")
            ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
            let isInteger = floor(ViewController.finalValue) == ViewController.finalValue
            if isInteger {
                resultLabel.text = String(Int(ViewController.finalValue))
            } else {
                resultLabel.text = String(Float(ViewController.finalValue))
            }
        }
    }
    
    
    func ac(){
        resultLabel.text = "0"
        ViewController.firstValue = 0.0
        ViewController.finalValue = 0.0
        ViewController.controller1 = 0
        ViewController.numCounter = 0
        ViewController.opStatus = false
        ViewController.equalDeduplicator = true
        ViewController.equalSetter = true
        ViewController.operationHandler = ""
        ViewController.additionalOpHandler = ""
        //Dot counter is new variable in order not to add multiple . on decimal number
        ViewController.dotCounter = 0
        //This variable is saying that number is last pressed
        ViewController.isNumLastPressed = true
        ViewController.equalCounter = 0
    }
}


//ViewController.equalDeduplicator = true
//            ViewController.firstValue = 0.0
//            ViewController.firstValue = 1
//            ViewController.dotCounter = 0
//            ViewController.operationHandler = ""
//            ViewController.additionalOpHandler = ""
//            ViewController.controller1 = 0




// num button case


// }else if resultLabel.text == "0." && ViewController.opStatus == false && resultLabel.text != "undefined" && ViewController.isDotLastSend == true{
//            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
//            ViewController.firstValue = 0.0
//            if let numValue = resultLabel.text {
//                ViewController.finalValue = Double(numValue)!
//            }
//            print("numOneButton else if 1")


// num button case

//} else if ViewController.dotCounter == 1 && resultLabel.text != "undefined" {
//            ViewController.controller1 = 0
//            print("numOneButton else if 3")
