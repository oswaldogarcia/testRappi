//
//  CategoryTable.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/18/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class CategoryTable: UITableViewController {
    
   
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesIdentifier")
        
         self.categories = try! Realm().objects(Category.self)
        self.navigationItem.title = "Apps Categories"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    
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
        
        return categories!.count
        
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesIdentifier", for: indexPath) as! CategoryTableViewCell
        
    cell.setData(category: (self.categories?[indexPath.row])!)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryID = self.categories?[indexPath.row].id
        
        self.performSegue(withIdentifier: "toApps", sender: categoryID )
        
        
    }
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "toApps" {
            
            if segue is CustomSegue {
                (segue as! CustomSegue).animationType = .SwipeDown
            }
            
            if let nextVC = segue.destination as? AppsTable {
                nextVC.categoryID = sender as! String
                
            }
        }
    
     }
    
    
}
