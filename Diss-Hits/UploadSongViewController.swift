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
    weak var documentPicker: UIDocumentPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        print("Hello")
        
        present(picker, animated: true, completion: nil)
        
        print("End")
        
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
        let types = [kUTTypeMP3, kUTTypeWaveformAudio, kUTTypeAudioInterchangeFileFormat, kUTTypeMIDIAudio, kUTTypeJPEG]
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
