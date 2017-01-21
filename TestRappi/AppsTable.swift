//
//  AppsTable.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/18/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class AppsTable: UITableViewController {
    
    var  apps: Results<App>?
    var  categoryID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib(nibName: "AppsTableViewCell", bundle: nil), forCellReuseIdentifier: "AppsIdentifier")
        
        
        self.apps = try! Realm().objects(App.self).filter("category.id = '\(categoryID)'")
        
        
        self.navigationItem.title = self.apps?[0].category?.label
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.apps!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppsIdentifier", for: indexPath) as! AppsTableViewCell
        
        cell.setData(app:(self.apps?[indexPath.row])!)
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appId =  self.apps?[indexPath.row].id
        
        self.performSegue(withIdentifier: "toAppDetail", sender:appId)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAppDetail" {
            
            if segue is CustomSegue {
                (segue as! CustomSegue).animationType = .SwipeDown
            }
            
            if let nextVC = segue.destination as? AppDetailViewController {
                nextVC.appId = sender as! String
            }
        }
        
    }
}
