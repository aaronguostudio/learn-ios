//
//  Item.swift
//  todoey
//
//  Created by ArronStudio on 2019-07-07.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
