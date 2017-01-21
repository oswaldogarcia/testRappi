//
//  ViewController.swift
//  TestRappi
//
//  Created by Oswaldo Garcia on 1/18/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController {
    
    let manager = Manager()
    
    @IBOutlet weak var lbNameApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        
    }
    
    func loadData() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 0.9)
        animation.duration = 0.6
        animation.repeatCount = 4.0
        animation.autoreverses = true
        
        self.lbNameApp.layer.add(animation, forKey: "transform.scale")
        
        
        if (self.manager.connectedToNetwork()){
            
            
            self.manager.request(completionHandler: { (result) in
                if (result){
                    
                    self.loadCategoriesViewController()
                    
                }
                
            })
            
        }else{
            
            var message = ""
            var title  = ""
            var next :Bool
            
            let apps = try! Realm().objects(App.self)
            
            if (apps.count > 0 ){
                
                title = "Warning"
                message = "There's no internet connection. Last connection data will be used."
                
                next = true
                self.loadCategoriesViewController()
                
            }else{
                title = "Error"
                message = "You need internet conexion to get started with this application."
                next = false
            }
            
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
                
            }
            let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                
                if !next {
                    self.loadData()
                }
                
            }
            
            if !next {
               alertController.addAction(tryAgainAction)
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    func loadCategoriesViewController(){
        var viewController : UIViewController?
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            viewController = storyboard.instantiateViewController(withIdentifier: "CategoryTable")
            
        }else if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            viewController = storyboard.instantiateViewController(withIdentifier: "CategoryCollection")
        }
        
        if let viewController = viewController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

