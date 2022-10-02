//
//  SceneDelegate.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Developed by Harun Fazlic on 07/09/2022
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }
    
    public static var firstValue = 0.0
    public static var finalValue = 0.0
    public static var controller1 = 0
    public static var opStatus = false
    public static var equalDeduplicator = true
    public static var operationHandler = ""
    public static var additionalOpHandler = ""
    
    @IBOutlet var resultLabel: UILabel!
    @IBAction func numOneButton(_ sender: UIButton) {
        
        if resultLabel.text != "0" && ViewController.opStatus == false{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
        } else {
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = numValue
                ViewController.opStatus = false
                ViewController.equalDeduplicator = true
            }
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if ViewController.equalDeduplicator == true{
            if let numValue = resultLabel.text{
                ViewController.firstValue = Double(numValue)!
                resultLabel.text = String(ViewController.firstValue)
                ViewController.operationHandler = (sender.titleLabel?.text)!
                
                
                if ViewController.controller1 == 0 && (sender.titleLabel?.text == "+" || sender.titleLabel?.text == "-"){
                    contain(x: ViewController.firstValue, op: ViewController.operationHandler, y: 0)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                } else if ViewController.controller1 == 0 && (sender.titleLabel?.text == "*" || sender.titleLabel?.text == "/"){
                    contain(x: ViewController.firstValue, op:ViewController.operationHandler, y: 1.0)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                } else {
                    contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: ViewController.firstValue)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                }
                ViewController.opStatus = true
            }
        }
        
        ViewController.controller1 += 1
        ViewController.operationHandler = (sender.titleLabel?.text)!
        
        if let opHandler = sender.titleLabel?.text{
            ViewController.operationHandler = opHandler
            ViewController.additionalOpHandler = opHandler
        }
        ViewController.equalDeduplicator = false
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if ViewController.equalDeduplicator == true{
            if let numValue = resultLabel.text{
                let expression = NSExpression(format: "\(ViewController.finalValue)\(ViewController.operationHandler)\(numValue)")
                ViewController.finalValue  = (expression.expressionValue(with: nil, context: nil) as? Double)!
                if floor(ViewController.finalValue) == ViewController.finalValue{
                    resultLabel.text = String(format: "%.0f", ViewController.finalValue)
                } else {
                    resultLabel.text = String(format: "%.9f", ViewController.finalValue)
                }
                ViewController.opStatus = true
            }
        }
        ViewController.equalDeduplicator = false
    }
    
    @IBAction func acButton(_ sender: UIButton) {
        resultLabel.text = "0"
        ViewController.firstValue = 0
        ViewController.finalValue = 0
        ViewController.controller1 = 0
        ViewController.operationHandler = ""
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if Int(resultLabel.text ?? "0") != 0{
            if let numValue = resultLabel.text{
                if let toDouble = Double(numValue){
                    if toDouble > 0{
                        resultLabel.text? = "-\(resultLabel.text!)"
                    } else {
                        resultLabel.text? = String(resultLabel.text!.dropFirst())
                    }
                }
            }
        }
    }
    
    @IBAction func percentageButton(_ sender: UIButton) {
        if Int(resultLabel.text ?? "0") != 0{
            if let numValue = resultLabel.text{
                if let toDouble = Double(numValue){
                    ViewController.finalValue = toDouble / 100
                }
                resultLabel.text? = String(ViewController.finalValue)
            }
        }
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if let currentValue = resultLabel.text{
            if currentValue.contains("."){
            }else{
                resultLabel.text = resultLabel.text?.appending(".")


            }
        }
    }
    
    
    
    
}











