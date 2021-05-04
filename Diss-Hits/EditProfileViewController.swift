//
//  EditProfileViewController.swift
//  Diss-Hits
//
//  Created by Jose Alfaro on 4/29/21.
//

import UIKit
import Parse
import MobileCoreServices
import AlamofireImage
import UniformTypeIdentifiers

class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
   
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioField: UITextField!
    weak var documentPicker: UIDocumentPickerViewController?

    
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
        let types = [kUTTypePNG, kUTTypeJPEG, kUTTypeImage, kUTTypeJPEG2000, kUTTypeRawImage]
        let importMenu = UIDocumentMenuViewController(documentTypes: types as [String], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
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
        if let value = UserDefaults.standard.string(forKey: "username"){
            nameLabel.text = value
        } else{
            nameLabel.text = ""
        }
        
        bioField.delegate = self
        if let value = UserDefaults.standard.string(forKey: "Bio"){
            bioLabel.text = value
        } else{
            bioLabel.text = ""
        }
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        nameLabel.text = nameField.text
        UserDefaults.standard.set(nameField.text, forKey: "username")
        
        bioLabel.text = bioField.text
        UserDefaults.standard.set(bioField.text, forKey: "Bio")
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            currentUser!["username"] = nameField.text
            currentUser!["Bio"] = bioField.text

            let imageData = imageView.image!.pngData()
            let file = PFFileObject(name: "image.png", data: imageData!)
            
            currentUser!["userPfp"] = file
            
            currentUser!.saveInBackground()
        }
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
        guard let image = UIImage(contentsOfFile: myURL.path) else {
            print("Not image file")
            return
        }
        imageView.image = image
    }
          

    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentedViewController == nil && self.documentPicker != nil {
            self.documentPicker = nil
        }else{
            super.dismiss(animated: flag, completion: completion)
        }
    }

    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent is UIDocumentPickerViewController {
            self.documentPicker = viewControllerToPresent as? UIDocumentPickerViewController
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
