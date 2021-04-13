//
//  ViewController.swift
//  Diss-Hits
//
//  Created by Jesus Caballero on 4/6/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        // ...
        if(GIDSignIn.sharedInstance()?.hasPreviousSignIn() == true) {
            let userInfo = self.appDelegate.getUserData()
            label.text = "Hello, \(userInfo.fullName)";
        }
    }
    
    @IBAction func signOutButton(_ sender: AnyObject) {
        GIDSignIn.sharedInstance()?.signOut()
        label.text = "You've been signed out";
    }

}
