//
//  AppsCollection.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


private let reuseIdentifier = "AppsCell"

class AppsCollection: UICollectionViewController {
    
    var  apps: Results<App>?
    var  categoryID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "AppsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.apps = try! Realm().objects(App.self).filter("category.id = '\(categoryID)'")
        
        
        self.navigationItem.title = self.apps?[0].category?.label
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
        
        return self.apps!.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppsCollectionViewCell
        
        cell.setData(app:(self.apps?[indexPath.row])!)
        
        
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
        
        if segue.identifier == "toAppDetail" {
            
            if segue is CustomSegue {
                (segue as! CustomSegue).animationType = .GrowScale
            }
            if let nextVC = segue.destination as? AppDetailViewController {
                nextVC.appId = sender as! String
            }
        }
        
    }
    // MARK: UICollectionViewDelegate
    
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let appId =  self.apps?[indexPath.row].id
        
        
        if collectionView.cellForItem(at: indexPath as IndexPath) != nil {
            self.performSegue(withIdentifier: "toAppDetail", sender:appId)
            
        }
        
        
        
        return true
    }
    
    
    
    
}
