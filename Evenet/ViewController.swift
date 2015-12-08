//
//  Login screen
//  ViewController.swift
//  Evenet
//
//  Created by Kalli Martin on 12/8/15.
//  Copyright © 2015 Evenet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ref = Firebase(url: "https://evenet.firebaseio.com/")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if ref.authData != nil {
        self.performSegueWithIdentifier("loginComplete", sender:self)
        }
    }

    @IBAction func login(sender: AnyObject) {
        ref.authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error, authData) -> Void in
                if error != nil {
                    
                    switch (error.code) {
                    case -5: // invalid email
                            self.errorLabel.text = "Invalid email."
                            print(error)
                            break;
                        case -6: // invalid password
                            self.errorLabel.text = "Incorrect password."
                            print(error)
                            break;
                        case -8: // user does not exist
                            self.errorLabel.text = "Account does not exist."
                            print(error)
                            break;
                        default:
                            self.errorLabel.text = "Unknown error."
                            print("Error logging user in:", error);
                    }
                } else {
                    print("login successful")
                    self.performSegueWithIdentifier("login", sender: self)
                    
                }
            })
    }
}