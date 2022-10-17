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
    //This variable is saying that number is last pressed
    public static var isNumLastPressed = true
    
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
        ViewController.isNumLastPressed = false
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
        
        //reseting dot button
        ViewController.dotCounter = 0
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
        
        //what this has naver beeen implmented
     ViewController.firstValue = 0.0
//        ViewController.finalValue = 0.0
        
        //reseting dot button
        ViewController.dotCounter = 0

    }
    
    @IBAction func acButton(_ sender: UIButton) {
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
        ViewController.isNumLastPressed = true
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
            
            
            
            //CASE1 equal is last button pressed, user entering new value
        if ViewController.equalSetter == false && ViewController.dotCounter == 1{
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
            
            //CASE3 number is laste entered, but number should be without .
        }else if ViewController.isNumLastPressed == false && !numValue.contains(".") {
            resultLabel.text? = numValue.appending(".")
            print("dot button case 3")
            
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
            
        }
    }
}



