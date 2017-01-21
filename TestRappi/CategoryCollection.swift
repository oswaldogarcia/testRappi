//
//  CategoryCollection.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

private let reuseIdentifier = "CategoryCell"

class CategoryCollection: UICollectionViewController {
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         self.navigationItem.title = "Apps Categories"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    
        self.collectionView!.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.categories = try! Realm().objects(Category.self)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        
        cell.setData(category: (self.categories?[indexPath.row])!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(4 - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(4))
        return CGSize(width: size, height: size )
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toApps" {
            
            if segue is CustomSegue {
                (segue as! CustomSegue).animationType = .GrowScale
            }
            if let nextVC = segue.destination as? AppsCollection {
                nextVC.categoryID = sender as! String
                
            }
        }
        
    }
    
    // MARK: UICollectionViewDelegate
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let categoryID = self.categories?[indexPath.row].id
        
        
        
        if collectionView.cellForItem(at: indexPath as IndexPath) != nil {
            self.performSegue(withIdentifier: "toApps", sender: categoryID )
        }
        
        
        return true
    }
    
    
}
