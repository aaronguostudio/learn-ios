//
//  Category.swift
//  todoey
//
//  Created by ArronStudio on 2019-07-07.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
