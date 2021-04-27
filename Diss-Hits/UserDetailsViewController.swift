//
//  UserDetailsViewController.swift
//  Diss-Hits
//
//  Created by Mytzy Escalante on 4/26/21.
//

import UIKit
import Parse
import GoogleSignIn

class UserDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil);
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate;
        let loginView = main.instantiateViewController(identifier: "LoginView");
        GIDSignIn.sharedInstance()?.signOut();
        
        PFUser.logOut();
        delegate.window?.rootViewController = loginView;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
