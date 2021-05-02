//
//  ArtistActivityViewController.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 5/1/21.
//

import UIKit
import AVFoundation
import Parse
import AlamofireImage

class ArtistActivityViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
//    var artist:[String:Any]!
    var artist = PFUser()
//    var artist = PFObject()
//    let albumCover = song["albumCover"] as? PFFileObject
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                print("SONGS")
            case 1:
                print("PLAYLISTS")
            default:
                break
        }
    }
    //
//    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
//        switch segmentControl.selectedSegmentIndex {
//            case 0:
//                label.text = "Artists' songs"
//            case 1:
//                label.text = "Playlists"
//            default:
//                break
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("NEW SCREEN")
        print(artist)
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
