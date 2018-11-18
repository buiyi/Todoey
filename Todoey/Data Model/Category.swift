//
//  Category.swift
//  Todoey
//
//  Created by Murat Gürbüzdal on 18.11.2018.
//  Copyright © 2018 Murat Gürbüzdal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
    
}
