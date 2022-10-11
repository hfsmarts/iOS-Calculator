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


//was part of number batton from begining, making first stament if second else

//if resultLabel.text != "0" && ViewController.opStatus == false && resultLabel.text!.contains(".") {
//  resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
//
//    print("if statment passed and equalDeduplicator is \(ViewController.equalDeduplicator)")
//      
//} else















