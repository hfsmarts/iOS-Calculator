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
    //dajBOze
    public static var testVarFor = 0.0
    public static var intTester = 0
    
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
                    print("if radi")
                } else if ViewController.controller1 == 0 && (sender.titleLabel?.text == "*" || sender.titleLabel?.text == "/"){
                    contain(x: ViewController.firstValue, op:ViewController.operationHandler, y: 1.0)
                    ViewController.additionalOpHandler = ViewController.operationHandler

                    
                    
                    //and one of two numbers contains . must be added in order that app worsk properly
                }else if ViewController.decimalHelper == false && ViewController.equalDeduplicator == true {
                                      
                    if ViewController.intTester == 0 {
                        if let numValue = resultLabel.text{
                            ViewController.testVarFor = Double(numValue)!
                        }
                    }

//                    3.2 + 1.3 + will show 4.5
//                    5 - 9.5
                    
                    print("//////////////////")
                    print("ViewController final value is \(ViewController.finalValue)")
                    print("ViewController first value is \(ViewController.firstValue)")
                    print("ViewController testVarFor value is \(ViewController.testVarFor)")

                    contain(x: ViewController.testVarFor, op:ViewController.additionalOpHandler, y: ViewController.firstValue)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                    
                    ViewController.intTester += 1
                    
                    
                    
                    
                    
                } else {
                    print("else radi")

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
                
    
            }else if ViewController.equalSetter == false && ViewController.opStatus == true{
                resultLabel.text? = resultLabel.text?.appending(".") ?? "0"
                
                
                ViewController.decimalHelper = false
                ViewController.equalDeduplicator = true
                   
                
            }else if ViewController.equalDeduplicator == false {
                resultLabel.text? = "0".appending(".")
                ViewController.equalDeduplicator = true


                
                
            }else{
                resultLabel.text? = resultLabel.text?.appending(".") ?? "0"
            }
        }
        ViewController.opStatus = false
        ViewController.operationHandler = ""
    }
    
    
    
    
}










//            }else if currentValue.contains("."){

