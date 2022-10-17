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


//Comments, not needed for now
//and one of two numbers contains . must be added in order that app worsk properly
//                    3.2 + 1.3 + will show 4.5
//                    5 - 9.5



//}else if ViewController.decimalHelper == false && ViewController.equalDeduplicator == true {
//    
//    if ViewController.intTester == 0 {
//        if let numValue = resultLabel.text{
//            ViewController.testVarFor = Double(numValue)!
//        }
//    }
//    
//    print("//////////////////")
//    print("ViewController final value is \(ViewController.finalValue)")
//    print("ViewController first value is \(ViewController.firstValue)")
//    print("ViewController testVarFor value is \(ViewController.testVarFor)")
//    
//    contain(x: ViewController.testVarFor, op:ViewController.additionalOpHandler, y: ViewController.firstValue)
//    ViewController.additionalOpHandler = ViewController.operationHandler
//    
//    ViewController.intTester += 1
//    
//


//            }else if ViewController.equalSetter == false && ViewController.opStatus == true{
//                resultLabel.text? = resultLabel.text?.appending(".") ?? "0"
//                print("dot button case 2")
//                ViewController.equalDeduplicator = true
//
//            }else if ViewController.equalDeduplicator == false {
//                resultLabel.text? = "0".appending(".")
//                ViewController.equalDeduplicator = true
//                print("dot button case 3")
    
    
    
    
    
    
    
    
    
    
    
    
    
    
