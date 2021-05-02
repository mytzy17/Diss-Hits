//
//  ArtistActivityViewController.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 5/1/21.
//

import UIKit

class ArtistActivityViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                label.text = "Artists' songs"
            case 1:
                label.text = "Playlists"
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
        label.text = "orignal"
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
