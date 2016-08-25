//
//  ViewController.swift
//  Be_Helpful_App
//
//  Created by Michael Merani on 7/7/16.
//  Copyright © 2016 Michael Merani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToSignUp(sender: UIButton!) {
        self.performSegueWithIdentifier("signup", sender: nil)
    }
    @IBAction func attemptLogin(Sender: UIButton!){
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
                    self.login()
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and password")
        }
        
    }
    func showErrorAlert(title: String,msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: {
            user, error in
            if error != nil{
                print(error)
                self.showErrorAlert("Could not login", msg: "Please check username or password.")
            } else {
                self.performSegueWithIdentifier("loggedin", sender: nil)
            }
        })
    }

}

