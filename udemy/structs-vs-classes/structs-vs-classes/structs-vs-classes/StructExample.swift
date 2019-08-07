//
//  StructExample.swift
//  structs-vs-classes
//
//  Created by ArronStudio on 2019-08-06.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation

struct SuperheroStuct {
    var name: String
    var universe: String
    
    func reverseName() -> String {
        String(self.name.reversed())
    }
    
    // struct can prevent accidently mutating the original value
    // unless add mutating keyword
    mutating func reverseNameMutable() {
        self.name = String(self.name.reversed())
    }
}

