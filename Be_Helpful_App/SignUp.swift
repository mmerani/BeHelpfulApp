//
//  SignUp.swift
//  Be_Helpful_App
//
//  Created by Michael Merani on 7/23/16.
//  Copyright © 2016 Michael Merani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUp: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createUser(sender: UIButton!) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "", let name = nameField.text where name != "", let school = schoolField.text where school != "" {
            FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { user, error in
                
                if error != nil{
                   
                    
                } else {
                    guard let uid = user?.uid else {
                        return
                    }
                    let rootRef = FIRDatabase.database().referenceFromURL("https://be-helpful.firebaseio.com/")
                    let usersReference = rootRef.child("users").child(uid)
                    let values = ["name": name, "email": email, "school": school]
                    usersReference.updateChildValues(values, withCompletionBlock: {(error,rootRef) in
                        if error != nil {
                            print(error)
                            return
                        }
                        
                    })
                    print("User Created")
                    self.nameField.text = ""
                    self.passwordField.text = ""
                    self.emailField.text = ""
                    self.schoolField.text = ""
                    
                    self.showErrorAlert("User Created!", msg: "Please return to Log in")
                  
                }
            })
            
        } else {
            showErrorAlert("All fields required", msg: "Please fill out all fields")
        }

        
    }    
    
    
    @IBAction func returnToSignIn(sender: UIButton!) {
        self.performSegueWithIdentifier("backToSignIn", sender: nil)
    }
    
    func showErrorAlert(title: String,msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }


}
