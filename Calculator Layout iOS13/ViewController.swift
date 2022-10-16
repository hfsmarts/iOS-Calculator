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
    
    public static var equalSetter = true
    public static var decimalHelper = true
    
    public static var operationHandler = ""
    public static var additionalOpHandler = ""
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func numOneButton(_ sender: UIButton) {
        if ViewController.equalSetter == false && resultLabel.text != "0" && ViewController.opStatus == true {
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
            
    }else if resultLabel.text != "0" && ViewController.opStatus == false{
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
        ViewController.equalSetter = true
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if ViewController.equalDeduplicator == true{
            if let numValue = resultLabel.text{
                contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: Double(numValue)!)
                ViewController.opStatus = true
            }
        }
        ViewController.equalDeduplicator = false
        ViewController.equalSetter = false
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
                        ViewController.finalValue = Double(resultLabel.text!)!
                    } else {
                        resultLabel.text? = String(resultLabel.text!.dropFirst())
                        ViewController.finalValue = Double(resultLabel.text!)!
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
            if currentValue.contains(".") && ViewController.equalDeduplicator == false {
                resultLabel.text? = "0".appending(".")
                ViewController.equalDeduplicator = true
                print("dot button case 1")
    
            }else if ViewController.equalSetter == false && ViewController.opStatus == true{
                resultLabel.text? = resultLabel.text?.appending(".") ?? "0"
                print("dot button case 2")

                ViewController.decimalHelper = false
                ViewController.equalDeduplicator = true
                   
            }else if ViewController.equalDeduplicator == false {
                resultLabel.text? = "0".appending(".")
                ViewController.equalDeduplicator = true
                print("dot button case 3")

            } else if ViewController.equalDeduplicator == false{
                
            }
            
//            else{
//                print("dot button case 4")
//                resultLabel.text? = resultLabel.text?.appending(".") ?? "0"
//                ViewController.equalDeduplicator = false
//            }
        }
        ViewController.opStatus = false
        ViewController.operationHandler = ""
        
    }
    
    
    
    
}










//            }else if currentValue.contains("."){

