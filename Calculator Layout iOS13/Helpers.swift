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
    func equalFunc(){

    }
}





extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
