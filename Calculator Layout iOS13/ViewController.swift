
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
    public static var isOperationLast = false
    public static var isReadyForEqual = true
    public static var equalSetter = true
    public static var isNumLastPressed = false
    public static var isDotLastSend = false
    public static var operationHandler = ""
    public static var additionalOpHandler = ""
    public static var numberTappedCounter = 0
    public static var dotCounter = 0 /*counts dots in decimal number in order to have just one*/
    public static var equalCounter = 0 /*after result is shown equal press will not show other results*/
    public static var numCounter = 0
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func numOneButton(_ sender: UIButton) {
        if ViewController.equalSetter == false && resultLabel.text != "0" && ViewController.isOperationLast == true{
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
                ViewController.isOperationLast = false /**FICA-52**/
            }
            
        } else if resultLabel.text != "0"  && ViewController.isOperationLast == false && resultLabel.text != "undefined"{
            resultLabel.text = resultLabel.text! + (sender.titleLabel?.text)!
            ViewController.isReadyForEqual = true
            
        } else if resultLabel.text == "undefined" {
            ac()
            resultLabel.text = (sender.titleLabel?.text)!
            if let numValue = resultLabel.text {
                ViewController.finalValue = Double(numValue)!
            }
            
        }  else {
            if let numValue = sender.titleLabel?.text{
                resultLabel.text = numValue
                ViewController.isReadyForEqual = true
                ViewController.isOperationLast = false
            }
        }
        ViewController.isNumLastPressed = true
        ViewController.isDotLastSend = false
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
                
            }else if numValue.last == "." && ViewController.isReadyForEqual == true{
                resultLabel.text = numValue
                ViewController.isReadyForEqual = true
                
            }else if ViewController.numberTappedCounter == 0{
                if let toDouble = Double(resultLabel.text!){
                    ViewController.finalValue = toDouble
                }
                
            }else if ViewController.isReadyForEqual {
                contain(x: ViewController.finalValue, op:ViewController.additionalOpHandler, y: Double(numValue)!)
                ViewController.isOperationLast = true
                
            } else {
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
                        ViewController.firstValue = Double(resultLabel.text!)! /**FICA-60**/
                    }else if toDouble == 0{ /*FICA-55*/
                    } else {
                        resultLabel.text? = String(resultLabel.text!.dropFirst())
                        ViewController.firstValue = Double(resultLabel.text!)! /**FICA-60**/
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
                
            } else if !numValue.contains(".") && ViewController.equalSetter == true && ViewController.isReadyForEqual == false{
                resultLabel.text? = "0".appending(".")
                
            } else if  resultLabel.text != "undefined" && !numValue.contains("."){
                resultLabel.text? = numValue.appending(".")
                
            } else  if ViewController.equalSetter == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.equalSetter = true
                
            }else if ViewController.isReadyForEqual == false && ViewController.dotCounter == 1{
                resultLabel.text? = "0".appending(".")
                ViewController.isReadyForEqual = true
                
            }else if numValue == "0" {
                resultLabel.text? = numValue.appending(".")
                
            }else{
            }
            ViewController.isOperationLast = false
            ViewController.operationHandler = ""
            ViewController.isReadyForEqual = true
        }
    }
}



