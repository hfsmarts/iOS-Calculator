//
//  Helpers.swift
//  Calculator iOS16
//
//  Created by Harun Fazlic on 07/09/2022.
//

import UIKit
import Foundation

extension ViewController {
    func contain(x: Double, op: String, y: Double){
        if (y == 0.0 || y == 0) && op == "/"{
            
            ViewController.isReadyForEqual = false
            ViewController.equalSetter = false
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.numCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
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
        ViewController.numberTappedCounter = 0
        ViewController.numCounter = 0
        ViewController.isOperationLast = false
        ViewController.isReadyForEqual = true
        ViewController.equalSetter = true
        ViewController.isNumLastPressed = false
        ViewController.isDotLastSend = false
        ViewController.operationHandler = ""
        ViewController.additionalOpHandler = ""
        ViewController.dotCounter = 0
        ViewController.equalCounter = 0
        ViewController.numCounter = 0
    }
}

