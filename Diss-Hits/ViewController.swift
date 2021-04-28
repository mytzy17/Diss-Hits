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
            let userData = appDelegate.getUserData();
            let query = PFQuery(className:"_User");
            query.whereKey("GID", equalTo: userData.userId);
            
            //let count = query.countObjects(nil);
            
            /*
            if(count == 0) {
                self.performSegue(withIdentifier: "RegisterSegue", sender: self);
            } else {
                self.performSegue(withIdentifier: "loginToHome", sender: nil);
            }
             */
       
            query.findObjectsInBackground { (results: [PFObject]?, error: Error?)
                in
                if let error = error {
                    //could not find user
                    print(error.localizedDescription);
                } else {
                    //find succeeded
                    if(results == nil || results?.isEmpty == true) {
                        self.performSegue(withIdentifier: "RegisterSegue", sender: self);
                    } else if let results = results {
                        
                        print(results)
                        
                        let username = results[0]["username"]
                        
                        print(username!)
                        let password = userData.userId
                        
                        PFUser.logInWithUsername(inBackground: username as! String, password: password) {
                          (user, error) in
                          if user != nil {
                            self.performSegue(withIdentifier: "loginToHome", sender: self);
                //            print(username)
                          }
                          else {
                            print("Error: \(error?.localizedDescription)")
                          }
                        }
                        
                    }
                }
            }
        
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
