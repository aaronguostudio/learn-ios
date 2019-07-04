//
//  ItemDataModel.swift
//  todoey
//
//  Created by ArronStudio on 2019-07-03.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit

class Item : Encodable {
    var title : String = ""
    var done : Bool = false
}
