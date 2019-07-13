//
//  Item.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-13.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdAt: Date?
    var category = LinkingObjects(fromType: Category.self, property: "items")
}
