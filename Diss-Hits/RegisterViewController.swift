//
//  RegisterViewController.swift
//  Diss-Hits
//
//  Created by Misael Guijarro on 4/19/21.
//

import UIKit
import Parse

class RegisterViewController: ViewController {


    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tryToRegister(_ sender: Any) {
        let posUsername = usernameField.text!;
        let description = descriptionField.text!;
        
        if(posUsername.isEmpty || description.isEmpty) {
            let alert = UIAlertController(title: "Incomplete Information", message: "Both the username and description fields need to be filled out.", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true);
            return;
        }
        
        let userInfo = appDelegate.getUserData();
        let user = PFUser();
        user.username = posUsername;
        user.password = userInfo.userId;
        
        /*
        user.add(userInfo.userId, forKey: "GID");
        user.add(description, forKey: "Bio");
        */
        
        user["GID"] = userInfo.userId;
        user["Bio"] = description;
        //user["email"] = userInfo.email;
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "RegisterToHome", sender: self);
            } else {
                print("Error: \(error)")
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
