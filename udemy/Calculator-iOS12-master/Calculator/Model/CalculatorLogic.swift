//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by ArronStudio on 2019-08-06.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    
    mutating func setNumber (_ number: Double) {
        self.number = number
    }
    
    func calculate (symbol: String) -> Double? {
        if let n = number {
            if symbol == "+/-" {
                return n * -1
            }
            if symbol == "AC" {
                return n * 0
            }
            if symbol == "%" {
                return n * 0.01
            }
        }
        
        return nil
    }
}
