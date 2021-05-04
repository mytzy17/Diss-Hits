//
//  EditProfileViewController.swift
//  Diss-Hits
//
//  Created by Jose Alfaro on 4/29/21.
//

import UIKit
import Parse


class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        changes()
        userDeatails()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          let image = info[.editedImage] as! UIImage

          let size = CGSize(width: 200, height: 200)
          let scaledImage = image.af.imageScaled(to: size)

          imageView.image = scaledImage

          dismiss(animated: true, completion: nil)

      }

      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
      }

    @IBAction func onProfileImage(_ sender: Any) {
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true

            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = .camera

            } else {
                picker.sourceType = .photoLibrary
            }

            present(picker, animated: true, completion: nil)
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
                        
                        self.imageView.af.setImage(withURL: url)
                    }
                    
                    self.nameLabel.text = results[0]["username"] as! String
                    
                    self.bioLabel.text = results[0]["Bio"] as! String
               }
            }
        }
    }
    
    func changes(){
        nameField.delegate = self
        if let value = UserDefaults.standard.string(forKey: "name"){
            nameLabel.text = value
        } else{
            nameLabel.text = ""
        }
        
        bioField.delegate = self
        if let value = UserDefaults.standard.string(forKey: "bio"){
            bioLabel.text = value
        } else{
            bioLabel.text = ""
        }
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        nameLabel.text = nameField.text
        UserDefaults.standard.set(nameField.text, forKey: "name")
        
        bioLabel.text = bioField.text
        UserDefaults.standard.set(bioField.text, forKey: "bio")
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
