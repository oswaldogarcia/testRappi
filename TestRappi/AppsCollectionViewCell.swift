//
//  AppsCollectionViewCell.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit

class AppsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbArtist: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ivImage.layer.masksToBounds = true
        self.ivImage.layer.cornerRadius = 10
        self.ivImage.layer.borderWidth = 1
        self.ivImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setData(app: App){
        
        self.lbName.text = app.name
        
        self.lbArtist.text = app.artist
        
        let url = URL(string: app.image)
        
        self.ivImage.kf.setImage(with: url)
    }

}
