//
//  SignUpViewController.swift
//  Evenet
//
//  Created by Kalli Martin on 12/8/15.
//  Copyright © 2015 Evenet. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var ref = Firebase(url: "https://evenet.firebaseio.com/")
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func createUserButton(sender: AnyObject) {
        
        if firstNameTextField.text == "" || lastNameTextField.text == ""
        {
                errorLabel.text = "All fields are required."
        } else if (passwordTextField.text == "" || confirmPasswordTextField.text == "" || passwordTextField.text != confirmPasswordTextField.text)
        {
             errorLabel.text = "Passwords to not match."
        }
        else {
            ref.createUser(emailTextField.text, password: passwordTextField.text, withValueCompletionBlock: { (error, result) -> Void in
                if error != nil {
                    if (error.code == -9)
                    {
                        self.errorLabel.text = "Email already in use."
                    }
                    print(error)
                } else {
                    print ("Successful sign up")
                    self.ref.authUser(self.emailTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, authData) -> Void in
                        if error != nil {
                            print(error) }
                        else {
                            print("login successful")
                            
                            let userID = authData.uid
                            let newUser = [
                                "provider" : authData.provider,
                                "email" : authData.providerData["email"] as! NSString as String,
                                "firstName" : self.firstNameTextField.text,
                                "lastName" : self.lastNameTextField.text
                            
                            ]
                            
                            self.ref.childByAppendingPath("users").childByAppendingPath(userID).setValue(newUser)
                          
                            self.performSegueWithIdentifier("signUpComplete", sender: self)
                        }
                    })

                    
                    
                }
            })}
        
        
//        ref.createUser(email.text, password.text, withValueCompletionBlock: { (error, result) -> Void in
//            if error != nil {
//                println(error)
//                else
//                print("successful sign up")
//                ref.authUser( // same as login function
//                in else case
//                var userId = authData.uid
//                let newUser = [
//                "provider" : authData.provider,
//                "email" : authData.providerData["email"] as NSString as String
//                ]
//                
//                let fakePost = [
//                "\(NSDate())": "This is my first fake post"
//                ]
//                self.ref.childByAppendingPath["users"].childByAppendingPath[authData.uid].setValue(newUser)
//                self.ref.childByAppendingPath["users/\(authData.uid)/post").setValue(fakePost)

        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    

}
