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
        
        print("Value of x is \(x)")
        print("Value of op is \(op)")
        print("Value of y is \(y)")
        print("             ")
        
        if (y == 0.0 || y == 0) && op == "/"{
            ac()
            resultLabel.text = "undefined"

            print("cacthed")
        } else {
            
            let expression = NSExpression(format: "\(x)\(op)\(y)")
                ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
                let isInteger = floor(ViewController.finalValue) == ViewController.finalValue
                if isInteger {
                    resultLabel.text = String(Int(ViewController.finalValue))
                } else {
                    resultLabel.text = String(ViewController.finalValue)
            }
        }
    }
    
    
    func ac(){
        resultLabel.text = "0"
        ViewController.firstValue = 0.0
        ViewController.finalValue = 0.0
        ViewController.controller1 = 0
        ViewController.opStatus = false
        ViewController.equalDeduplicator = true
        ViewController.equalSetter = true
        ViewController.operationHandler = ""
        ViewController.additionalOpHandler = ""
        //Dot counter is new variable in order not to add multiple . on decimal number
        ViewController.dotCounter = 0
        //This variable is saying that number is last pressed
        ViewController.equalCounter = 0
        ViewController.isNumLastPressed = true
    }
    
}



    
    
    
    
    
