//
//  Category.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    dynamic var id : String  = ""
    dynamic var label : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
