//
//  App.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class App : Object {
    
    dynamic var id : String  = ""
    dynamic var name : String = ""
    dynamic var summary : String = ""
    dynamic var image : String = ""
    dynamic var artist : String = ""
    dynamic var category : Category?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
