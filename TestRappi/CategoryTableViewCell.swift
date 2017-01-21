//
//  CategoryTableViewCell.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbCatergory: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    

    override func awakeFromNib() {
               super.awakeFromNib()
    self.ivImage.layer.masksToBounds = true
    self.ivImage.layer.cornerRadius = 10
    self.ivImage.layer.borderWidth = 1
    self.ivImage.layer.borderColor = UIColor.lightGray.cgColor

        
    }
    
    func setData(category: Category){
        
        self.lbCatergory.text = category.label
        
        let appImg = try! Realm().objects(App.self).filter("category.id = '\(category.id)'")
        
        
        let APP = appImg[0]
        
        let url = URL(string: APP.image)
         
        self.ivImage.kf.setImage(with: url)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
