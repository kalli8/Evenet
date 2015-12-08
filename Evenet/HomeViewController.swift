//
//  HomeViewController.swift
//  Evenet
//
//  Created by Kalli Martin on 12/8/15.
//  Copyright © 2015 Evenet. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var ref = Firebase(url: "https://evenet.firebaseio.com/")
    
       override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        ref.unauth()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
