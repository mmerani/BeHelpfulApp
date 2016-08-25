//
//  Profile.swift
//  Be_Helpful_App
//
//  Created by Michael Merani on 7/21/16.
//  Copyright © 2016 Michael Merani. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class Profile: UIViewController {
    
    
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSchool: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkIfUserIsLoggedIn()
        
    }

  
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil{
            performSelector(#selector(handleLogOut),withObject: nil,afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.UserEmail.text = dictionary["email"] as? String
                    self.userName.text = dictionary["name"] as? String
                    self.userSchool.text = dictionary["school"] as? String
                }
                
                }, withCancelBlock: nil)
            
            }
    }
    
    
    func handleLogOut() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        
        }
    }
    

    
 

}
