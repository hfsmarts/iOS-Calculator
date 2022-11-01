
//  SceneDelegate.swift
//  Calculator iOS16
//
//  Created by Harun Fazlic on 07/09/2022.

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }
    public static var firstValue = 0.0
    public static var finalValue = 0.0
    public static var numberTappedCounter = 0
    public static var isOperationLast = false
    public static var isReadyForEqual = true
    public static var equalSetter = true
    public static var isNumLastPressed = false
    public static var isDotLastSend = false
    public static var operationHandler = ""
    public static var additionalOpHandler = ""
    //Dot counter is new variable in order not to add multiple . on decimal number
    public static var dotCounter = 0
    public static var equalCounter = 0
    public static var numCounter = 0
    
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func numOneButton(_ sender: UIButton) {
        if ViewController.equalSetter == false && resultLabel.text != "0" && ViewController.isOperationLast == true{
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
                ViewController.isOperationLast = false /**FICA-52**/
            }
            print("numOneButton if")
            
        } else if resultLabel.text != "0"  && ViewController.isOperationLast == false && resultLabel.text != "undefined"{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
            ViewController.isReadyForEqual = true
            print("numOneButton else if 2")
            
        } else if resultLabel.text == "undefined" {
            ac()
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
            print("numOneButton else if 3")
            
        }  else {
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = numValue
                ViewController.isReadyForEqual = true
                ViewController.isOperationLast = false
            }
            print("numOneButton else")
        }
        ViewController.isNumLastPressed = true
        ViewController.isDotLastSend = false
        print("numberTappedCounter is \(ViewController.numberTappedCounter)")
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if ViewController.isReadyForEqual == true{
            
            if let numValue = resultLabel.text{
                ViewController.firstValue = Double(numValue)!
                resultLabel.text = String(ViewController.firstValue)
                ViewController.operationHandler = (sender.titleLabel?.text)!
                
                if ViewController.numberTappedCounter == 0 && (sender.titleLabel?.text == "+" || sender.titleLabel?.text == "-"){
                    contain(x: ViewController.firstValue, op: ViewController.operationHandler, y: 0)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                    
                } else if ViewController.numberTappedCounter == 0 && (sender.titleLabel?.text == "*" || sender.titleLabel?.text == "/"){
                    contain(x: ViewController.firstValue, op:ViewController.operationHandler, y: 1.0)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                } else {
                    contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: ViewController.firstValue)
                    ViewController.additionalOpHandler = ViewController.operationHandler
                }
            }
        }
        
        ViewController.numberTappedCounter += 1
        ViewController.operationHandler = (sender.titleLabel?.text)!
        
        if let opHandler = sender.titleLabel?.text{
            ViewController.operationHandler = opHandler
            ViewController.additionalOpHandler = opHandler
        }
        ViewController.isOperationLast = true
        ViewController.isReadyForEqual = false
        ViewController.equalSetter = true
        ViewController.dotCounter = 0
        ViewController.numCounter = 0
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if let numValue = resultLabel.text{
                        
            if numValue == "0" && ViewController.firstValue != 0.0 /*FICA-53*/ && (ViewController.operationHandler == "/" || ViewController.additionalOpHandler == "/") {
                ac()
                resultLabel.text = "undefined"
                print("equal if")
                
            }else if numValue.last == "." && ViewController.isReadyForEqual == true{
                resultLabel.text = numValue
                ViewController.isReadyForEqual = true
                //line below commented due to testing purposes
                //ViewController.isOperationLast = true
                print("equal else if 2")
                
            }else if ViewController.numberTappedCounter == 0{
                if let toDouble = Double(resultLabel.text!){
                    ViewController.finalValue = toDouble
                    print("equal new")
                }
                
            }else if ViewController.isReadyForEqual {
                contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: Double(numValue)!)
                ViewController.isOperationLast = true
                print("equal else if 3")
                
            } else {
                print("equal else")
                resultLabel.text = resultLabel.text
            }
            
            ViewController.isReadyForEqual = false
            ViewController.equalSetter = false
            ViewController.firstValue = 0.0
            ViewController.dotCounter = 0
            ViewController.operationHandler = ""
            ViewController.additionalOpHandler = ""
            ViewController.numberTappedCounter = 0
            ViewController.isNumLastPressed = false
            ViewController.numCounter = 0
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
                        ViewController.firstValue = Double(resultLabel.text!)!
                        ViewController.finalValue = Double(resultLabel.text!)! /*FICA-54*/
                        print("if")
                    }else if toDouble == 0{ /*FICA-55*/
                    } else {
                        resultLabel.text? = String(resultLabel.text!.dropFirst())
                        ViewController.firstValue = Double(resultLabel.text!)!
                        ViewController.finalValue = Double(resultLabel.text!)! /*FICA-54*/
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
            
            if resultLabel.text == "undefined"{
                resultLabel.text? = "0".appending(".")
                ViewController.numberTappedCounter = 0
                ViewController.isDotLastSend = true
                print("dotButton else if 1")
                
                
            } else if !numValue.contains(".") && ViewController.equalSetter == true && ViewController.isReadyForEqual == false{
                resultLabel.text? = "0".appending(".")
                print("dotButton else if 2")
                
                //ovdje
            } else if  resultLabel.text != "undefined" && !numValue.contains("."){
                resultLabel.text? = numValue.appending(".")
                print("dotButton if")
                
            } else  if ViewController.equalSetter == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalSetter = true
                print("dotButton else if 3")
                
                
            }else if ViewController.isReadyForEqual == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.isReadyForEqual = true
                print("dotButton else if 4")
                
                
            }else if numValue == "0" {
                resultLabel.text? = numValue.appending(".")
                print("dotButton else if 5")
                
                
            }else{
                print("dotButton else")
                
            }
            ViewController.isOperationLast = false
            ViewController.operationHandler = ""
            ViewController.isReadyForEqual = true
        }
    }
}



