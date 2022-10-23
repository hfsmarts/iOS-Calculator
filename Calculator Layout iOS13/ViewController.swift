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
    public static var operationHandler = ""
    public static var additionalOpHandler = ""
    //Dot counter is new variable in order not to add multiple . on decimal number
    public static var dotCounter = 0
    public static var equalCounter = 0
    //This variable is saying that number is last pressed
    public static var isNumLastPressed = false
    @IBOutlet var resultLabel: UILabel!
    
    
    @IBAction func numOneButton(_ sender: UIButton) {
        if ViewController.equalSetter == false && resultLabel.text != "0" && ViewController.opStatus == true {
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
                print("num 1 if")
        }else if resultLabel.text != "0" && ViewController.opStatus == false && resultLabel.text != "undefined"{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
            print("num 2 else if, resultLabel.text = \(resultLabel.text!)")
            
            
            
            
            
            
            
            //FIRX FROM HERE
            
            
            
            
            
            
            //added from num4else
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = "0.\(numValue)"
                ViewController.opStatus = false
                ViewController.equalDeduplicator = true
            }
            
            
        }
            
            else if ViewController.dotCounter == 1 && resultLabel.text != "undefined" {
            ViewController.controller1 = 0
            print("CASEEEeeeeeee")
        }
        
        else if resultLabel.text == "undefined" {
            //    ac()
            resultLabel.text = (sender.titleLabel?.text)!
            ViewController.firstValue = 0.0
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
            print("num 3 else if")
            
            
            ViewController.equalDeduplicator = true
            //     ViewController.equalSetter = false
            
            
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
            ViewController.controller1 = 0
            ViewController.isNumLastPressed = true
            
            
            
            
            
            
        } else {
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = numValue
                ViewController.opStatus = false
                ViewController.equalDeduplicator = true
            }
            print("num 4 else")
        }
        
        ViewController.isNumLastPressed = true
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if ViewController.equalDeduplicator == true{
            
            if let numValue = resultLabel.text{
                print("VALUSSSS is \(numValue)")
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
        
        //reseting dot button
        ViewController.dotCounter = 0
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if let numValue = resultLabel.text{
            
            //Handling dividing with zero example 7/0 will show undefined
            if numValue == "0" && (ViewController.operationHandler == "/" || ViewController.additionalOpHandler == "/") {
                ac()
                resultLabel.text = "undefined"
            }
            
            //equal sign pressed resultLabel.text = 0
            else if numValue == "0"  && ViewController.equalDeduplicator == true{
                resultLabel.text = resultLabel.text
                ViewController.equalDeduplicator = true
                print("if works equal button")
            }
            
            //equal sign pressed . is the last item in resultLabel.text
            else if numValue.last == "." && ViewController.equalDeduplicator == true{
                resultLabel.text = "0"
                ViewController.equalDeduplicator = true
                print("else if 1 works equal button")
            }
            
            //calculation to be done, normal case, two cases above are extreme cases
            else if ViewController.equalDeduplicator == true{
                contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: Double(numValue)!)
                ViewController.opStatus = true
                print("else if 2 works equal button,  ")
                
                
                
            }
            ViewController.equalDeduplicator = false
            ViewController.equalSetter = false
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
            ViewController.controller1 = 0
            ViewController.isNumLastPressed = false
        }
    }
    
    @IBAction func acButton(_ sender: UIButton) {
        ac()
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
        ViewController.dotCounter += 1
        if let numValue = resultLabel.text{
            
           // CASE5
            
                     if  resultLabel.text != "undefined"{
                         resultLabel.text? = "0".appending(".")
                         print("hi")
                    }
            
            
            //     CASE4 same as CASE3      ViewController.equalSetter = false
           else if !numValue.contains(".") && ViewController.equalSetter == true && ViewController.equalDeduplicator == false{
                resultLabel.text? = "0".appending(".")
                //risky line below
                               print("dot button case 4")
            }
            
            
            //CASE3 number is laste entered, but number should be without .
            //            if ViewController.isNumLastPressed == true && !numValue.contains("."){
            //                resultLabel.text? = numValue.appending(".")
            //                //risky line below
            //                ViewController.equalDeduplicator = true
            //                ViewController.equalSetter = true
            //                print("dot button case 3")
            //            }
            //
            
            
            //CASE1 equal is last button pressed, user entering new value
            else  if ViewController.equalSetter == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalSetter = true
                print("dot button case 1")
                print(ViewController.dotCounter)
                
                //CASE2 + - * / is last button pressed
            }else if ViewController.equalDeduplicator == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalDeduplicator = true
                print("dot button case 2")
                print(ViewController.dotCounter)
                
                //CASE4 number is 0
            }else if numValue == "0" {
                resultLabel.text? = numValue.appending(".")
                print("dot button case 4")
                
                //CASE 5 any other case
            }else{
                print("dot button case 5")
            }
            
            ViewController.opStatus = false
            ViewController.operationHandler = ""
            
            //scary
            ViewController.equalDeduplicator = true
            
        }
    }
}



