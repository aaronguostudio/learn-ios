//
//  Category.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-13.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
