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
    @IBOutlet weak var pfpView: UIImageView!
    @IBOutlet weak var usernameView: UILabel!
    @IBOutlet weak var bioView: UILabel!
    
    var artist = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // print("NEW SCREEN")
        // print(artist)
        
        usernameView.text = artist.username
        let bioString = artist["Bio"] as! String
        bioView.text = bioString
        
        displayingSongs()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                displayingSongs()
            case 1:
                displayingPlaylists()
            default:
                break
        }
    }

    func displayingSongs() {
        print("SONGS YAY")
        print(artist.objectId)
        
        // will use object id to query artist songs
        // similar query user details
    }
    
    func displayingPlaylists() {
        print("PLAYLISTS WOW")
        print(artist.objectId)
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
