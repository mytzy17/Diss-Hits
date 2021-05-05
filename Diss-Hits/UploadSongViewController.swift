//
//  UploadSongViewController.swift
//  Diss-Hits
//
//  Created by Jesus Caballero on 4/26/21.
//

import UIKit
import Parse
import MediaPlayer
import AlamofireImage
import MobileCoreServices
import UniformTypeIdentifiers

class UploadSongViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate
 {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songTitle: UITextField!
    weak var documentPicker: UIDocumentPickerViewController?
    @IBOutlet weak var lyrics: UITextField!
    @IBOutlet weak var checkMark: UIImageView!
    
    
    var songFile: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        }
//        else {
//            picker.sourceType = .photoLibrary
//        }
//
//        print("Hello")
//
//        present(picker, animated: true, completion: nil)
//
//        print("End")
        let types = [kUTTypePNG, kUTTypeJPEG, kUTTypeImage, kUTTypeJPEG2000, kUTTypeRawImage]
        let importMenu = UIDocumentMenuViewController(documentTypes: types as [String], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectSongs(_ sender: UIButton) {
//        let controller = MPMediaPickerController(mediaTypes: .music)
//        controller.allowsPickingMultipleItems = true
//        controller.popoverPresentationController?.sourceView = sender
//        controller.delegate = self
//        present(controller, animated: true)
        let types = [kUTTypeMP3, kUTTypeWaveformAudio, kUTTypeAudioInterchangeFileFormat, kUTTypeMIDIAudio, kUTTypeAudio]
        let importMenu = UIDocumentMenuViewController(documentTypes: types as [String], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
        
        
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
        guard let image = UIImage(contentsOfFile: myURL.path) else {
            print("Not image file")
            
            guard let song = NSData(contentsOfFile: myURL.path) else {
                return
                
            }
            
            songFile = song;
            
            checkMark.isHidden = false
            
            print("Music file chosen")
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
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let upload = PFObject(className: "Songs")
        
        upload["songTitle"] = songTitle.text!
        upload["lyrics"] = lyrics.text!
        upload["artist"] = PFUser.current()!
        upload["genre"] = ["Classic rock"]
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        upload["albumCover"] = file
        
        let song = PFFileObject(data: songFile as Data)
        
        upload["songFile"] = song
        
        createSpinnerView(theUpload: upload);
        
//        upload.saveInBackground { (success, error) in
//
//            if success {
//                self.dismiss(animated: true, completion: nil)
//                print("Successfully uploaded!")
//            }
//            else {
//                print("Error Unsucessful post:\(error?.localizedDescription)")
//            }
//
//        }
        
        
    }
    
    func createSpinnerView(theUpload: PFObject) {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        DispatchQueue.main.async(execute: {
            theUpload.saveInBackground { (success, error) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Successfully uploaded!")
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
            else {
                print("Error Unsucessful post:\(error?.localizedDescription)")
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
            
            }
        })
        

        // wait two seconds to simulate some work happening
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            // then remove the spinner view controller
//            child.willMove(toParent: nil)
//            child.view.removeFromSuperview()
//            child.removeFromParent()
//        }
    }
    
    
    
//    func mediaPicker(_ mediaPicker: MPMediaPickerController,
//                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
//        // Get the system music player.
//        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
//        musicPlayer.setQueue(with: mediaItemCollection)
//        mediaPicker.dismiss(animated: true)
//        // Begin playback.
//        musicPlayer.play()
//    }
//
//    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
//        mediaPicker.dismiss(animated: true)
//    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
