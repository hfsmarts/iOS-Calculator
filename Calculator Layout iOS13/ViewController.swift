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
    public static var opStatus = false
    public static var equalDeduplicator = true
    public static var operationHandler = ""
    
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
        if let numValue = resultLabel.text{
            ViewController.firstValue = Double(numValue)!
            resultLabel.text = numValue
            ViewController.operationHandler = (sender.titleLabel?.text)!
            ViewController.opStatus = true
            ViewController.equalDeduplicator = true
        }
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
      equalFunc()
    }
    
    @IBAction func acButton(_ sender: UIButton) {
        resultLabel.text = "0"
        ViewController.firstValue = 0
        ViewController.finalValue = 0
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
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
    
    @IBAction func percentageButton(_ sender: UIButton) {
        if let numValue = resultLabel.text{
            if let toDouble = Double(numValue){
                ViewController.finalValue = toDouble / 100
            }
            resultLabel.text? = String(ViewController.finalValue)
        }
    }
}











