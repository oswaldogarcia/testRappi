//
//  AppDetailViewController.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/19/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher


class AppDetailViewController: UIViewController {
    
    @IBOutlet weak var lbAppName: UILabel!
    @IBOutlet weak var lbAppArtist: UILabel!
    @IBOutlet weak var lbAppCategory: UILabel!
    @IBOutlet weak var tfAppSummary: UITextView!
    @IBOutlet weak var ivAppImage: UIImageView!
    
    var  app: Results<App>?
    var  appId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.app = try! Realm().objects(App.self).filter("id = '\(appId)'")
        
        let APP = self.app![0]
        
        self.navigationItem.title = APP.name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        self.lbAppName.text = APP.name
        self.lbAppArtist.text = APP.artist
        self.lbAppCategory.text = APP.category?.label
        self.tfAppSummary.text = APP.summary
        self.tfAppSummary.scrollRangeToVisible(NSRange(location:0, length:0))
        
        let url = URL(string: APP.image)
        
        self.ivAppImage.kf.setImage(with: url)
        self.ivAppImage.layer.borderWidth = 1
        self.ivAppImage.layer.cornerRadius = 10
        self.ivAppImage.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
