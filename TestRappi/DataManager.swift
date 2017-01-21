//
//  DataManager.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import SystemConfiguration

class Manager {
    
    
    let url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    let realm = try! Realm()
    
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func request (completionHandler:@escaping (Bool) -> ()) {
        
        
        Alamofire.request(self.url).responseJSON { response in
            
            if let value = response.result.value {
                let json = JSON(value)
                
                for (_, subJson):(String, JSON) in json["feed"]["entry"] {
                    
                    let category = Category()
                    category.id = subJson["category"]["attributes"]["im:id"].string!
                    category.label = subJson["category"]["attributes"]["label"].string!
                    
                    let app = App()
                    app.id = subJson["id"]["attributes"]["im:id"].string!
                    app.name = subJson["im:name"]["label"].string!
                    app.summary = subJson["summary"]["label"].string!
                    app.image = subJson["im:image"][2]["label"].string!
                    app.artist = subJson["im:artist"]["label"].string!
                    app.category = category
                    
                    
                    
                    try! self.realm.write {
                        
                        self.realm.add(app,update: true)
                        
                    }
                    
                    
                }
                
            }
            
            completionHandler(true)
        }
        
    }
    
    
}
