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
  
    func contain(x: Double, y: Double){
        let expression = NSExpression(format: "\(x)\(ViewController.operationHandler)\(y)")
        let r = ViewController.firstValue.truncatingRemainder(dividingBy: ViewController.firstValue)
        if r == 0 {
            ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
            resultLabel.text = String(Int(ViewController.finalValue))
        } else {
            ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
            resultLabel.text = String(ViewController.finalValue)
        }
    }

    
    
    
    
    
}





//extension Decimal {
//    var significantFractionalDecimalDigits: Int {
//        return max(-exponent, 0)
//    }
//}



//Code used for decimal extenssion

//resultLabel.text = String(ViewController.finalValue)
//let n = Decimal(string: resultLabel.text!)
//var numOfDec = 10
//if let nUnwrapped = n {
//    numOfDec = nUnwrapped.significantFractionalDecimalDigits
//}
//if numOfDec >= 10{
//    var value  = UIInterfaceOrientation.landscapeRight.rawValue
//    if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight{
//        value = UIInterfaceOrientation.portrait.rawValue
//    }
//    UIDevice.current.setValue(value, forKey: "orientation")
//    UIViewController.attemptRotationToDeviceOrientation()
//}









//Code that was in plusButton

//if let numValue = resultLabel.text{
//    ViewController.firstValue = Double(numValue)!
//    resultLabel.text = numValue
//    ViewController.operationHandler = (sender.titleLabel?.text)!
//    ViewController.opStatus = true
//    ViewController.equalDeduplicator = false
//}
