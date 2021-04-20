//
//  ViewController.swift
//  Diss-Hits
//
//  Created by Jesus Caballero on 4/6/21.
//

import UIKit
import GoogleSignIn
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(userDidSignInGoogle(_:)),
                                                       name: .signInGoogleCompleted,
                                                       object: nil)
        
        //updateScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(GIDSignIn.sharedInstance()?.hasPreviousSignIn() == true) {
            //self.performSegue(withIdentifier: "loginToHome", sender: self);
        }
    }
    
    private func updateScreen() {
            
        if ((GIDSignIn.sharedInstance()?.currentUser) != nil) {
            // User signed in
//            print("perhaps?")
            
            // doesUserExist {
            let GID = appDelegate.getUserData();
            let query = PFQuery(className:"User");
            query.whereKey("GID", equalTo: GID.userId);
            
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?)
                in
                if let error = error {
                    //could not find user
                    print(error.localizedDescription);
                } else if let objects = objects {
                    //find succeeded
                    if(objects.count == 0) {
                        self.performSegue(withIdentifier: "RegisterSegue", sender: self);
                    } else {
                        self.performSegue(withIdentifier: "loginToHome", sender: self);
                    }
                }
            }
            // }
                
        } else {
            // User signed out
                
            // print("Nothing happens")
        }
    }
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        updateScreen()
    }
    
}
