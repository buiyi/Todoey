//
//  Item.swift
//  Todoey
//
//  Created by Murat Gürbüzdal on 18.11.2018.
//  Copyright © 2018 Murat Gürbüzdal. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var dateCreated:Date = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
