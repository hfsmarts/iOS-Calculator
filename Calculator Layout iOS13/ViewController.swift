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
    public static var isDotLastSend = false
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func numOneButton(_ sender: UIButton) {
        if ViewController.equalSetter == false && resultLabel.text != "0" && ViewController.opStatus == true {
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!            }
        }
        
        else if resultLabel.text == "0." && ViewController.opStatus == false && resultLabel.text != "undefined" && ViewController.isDotLastSend == true{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
            ViewController.firstValue = 0.0
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
        } else if resultLabel.text != "0" && ViewController.opStatus == false && resultLabel.text != "undefined"{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
            print("else if 1")
        } else if ViewController.dotCounter == 1 && resultLabel.text != "undefined" {
            ViewController.controller1 = 0
            print("else if 2")
        } else if resultLabel.text == "undefined" {
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
            ViewController.equalDeduplicator = true
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
            ViewController.controller1 = 0
            print("else if 3")
        }  else {
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = numValue
                ViewController.opStatus = false
                ViewController.equalDeduplicator = true
            }
            print("else")
        }
        ViewController.isNumLastPressed = true
        ViewController.isDotLastSend = false
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
        ViewController.dotCounter = 0
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if let numValue = resultLabel.text{
            
            if numValue == "0" && (ViewController.operationHandler == "/" || ViewController.additionalOpHandler == "/") {
                ac()
                resultLabel.text = "undefined"
            }
            
            else if numValue == "0"  && ViewController.equalDeduplicator == true{
                resultLabel.text = resultLabel.text
                ViewController.equalDeduplicator = true
            }
            
            else if numValue.last == "." && ViewController.equalDeduplicator == true{
                resultLabel.text = "0"
                ViewController.equalDeduplicator = true
            }
            
            else if ViewController.equalDeduplicator == true{
                contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: Double(numValue)!)
                ViewController.opStatus = true
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
            if  resultLabel.text != "undefined"{
                resultLabel.text? = "0".appending(".")
            }
            else if resultLabel.text == "undefined"{
                print(" . after value of label is undefined")
                resultLabel.text? = "0".appending(".")
                ViewController.controller1 = 0
                ViewController.isDotLastSend = true
                
            } else if !numValue.contains(".") && ViewController.equalSetter == true && ViewController.equalDeduplicator == false{
                resultLabel.text? = "0".appending(".")
            } else  if ViewController.equalSetter == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalSetter = true
            }else if ViewController.equalDeduplicator == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalDeduplicator = true
            }else if numValue == "0" {
                resultLabel.text? = numValue.appending(".")
            }else{
            }
            ViewController.opStatus = false
            ViewController.operationHandler = ""
            ViewController.equalDeduplicator = true
        }
    }
}



