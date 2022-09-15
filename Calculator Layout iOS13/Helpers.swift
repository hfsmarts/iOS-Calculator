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
    func equalFunc(){
        if ViewController.equalDeduplicator == true{
            if let numValue = resultLabel.text{
                let expression = NSExpression(format: "\(ViewController.firstValue)\(ViewController.operationHandler)\(numValue)")
                ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
                if floor(ViewController.finalValue) == ViewController.finalValue{
                    resultLabel.text = String(format: "%.0f", ViewController.finalValue)
                } else {
                    // resultLabel.text = String(format: "%.10f", ViewController.finalValue) 10 decimals no screen rotation
                    resultLabel.text = String(ViewController.finalValue)
                    let n = Decimal(string: resultLabel.text!)
                    var numOfDec = 10
                    if let nUnwrapped = n {
                        numOfDec = nUnwrapped.significantFractionalDecimalDigits
                    }
                    if numOfDec >= 10{
                        var value  = UIInterfaceOrientation.landscapeRight.rawValue
                        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight{
                            value = UIInterfaceOrientation.portrait.rawValue
                        }
                        UIDevice.current.setValue(value, forKey: "orientation")
                        UIViewController.attemptRotationToDeviceOrientation()
                    }
                }
                ViewController.opStatus = true
            }
        }
        ViewController.equalDeduplicator = false
    }
}





extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
