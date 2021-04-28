//
//  UserDetailsViewController.swift
//  Diss-Hits
//
//  Created by Mytzy Escalante on 4/26/21.
//

import UIKit
import Parse
import GoogleSignIn
import SwiftUI

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDeatails()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("oiadoiwajodiwjaoidwoaj")
//        self.userDeatails()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil);
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate;
        let loginView = main.instantiateViewController(identifier: "LoginView");
        GIDSignIn.sharedInstance()?.signOut();
        
        PFUser.logOut();
        delegate.window?.rootViewController = loginView;
    }
    
    func userDeatails() {
        
        let userData = appDelegate.getUserData();
        let query = PFQuery(className:"_User");
        query.whereKey("GID", equalTo: userData.userId);
        
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?)
            in
            if let error = error {
                //could not find user
                print(error.localizedDescription);
            } else {
                
                if let results = results {
                    print(results)
                    
//                    let username = results[0]["username"]
                    
                    if let imageFile = results[0]["userPfp"] as? PFFileObject {
                        let urlString = imageFile.url!
                        let url = URL(string: urlString)!
                        
                        self.userProfileImage.af.setImage(withURL: url)
                    }
                    
                    self.username.text = results[0]["username"] as! String
                    
                    self.userBio.text = results[0]["Bio"] as! String
                    
                    
                    
                    
                   
                
               }
                
            }
        }
        
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
