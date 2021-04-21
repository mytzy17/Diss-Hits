//
//  MusicPlayerViewController.swift
//  Diss-Hits
//
//  Created by Josue Quintero on 4/13/21.
//

import UIKit
import AVFoundation
import Parse

class MusicPlayerViewController: UIViewController {
    
    var queriedSongs = [PFFileObject]()
    var currentSong = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searcher(_ sender: Any) {
//        var query = PFQuery(className:"Songs")
//
//        query.getObjectInBackground(withId: input) {
//          (parseObject: PFObject?, error: NSError?) -> Void in
//          if error == nil && parseObject != nil {
//            print(parseObject)
//          } else {
//            print(error)
//          }
//        }
        
        let input = "0tEAJSpk5W"
        print("in the searcher")
        
        let query = PFQuery(className:"Songs")
        query.includeKeys(["artist", "lyrics", ""])

        query.getObjectInBackground(withId: input) { (songs, error) in
            if error == nil {
                // Success!
//                print(songs!["lyrics"]!)
                self.queriedSongs.append(songs!["songFile"] as! PFFileObject)
                print(self.queriedSongs[0])
            } else {
                // Fail!
                print(error!)
            }
        }

    }
    
    
    @IBOutlet weak var playButton: UIButton!
    var player: AVAudioPlayer?
    
    
    @IBAction func playMusic(_ sender: Any) {
        print("playMusic")
        if let player = player, player.isPlaying {
            player.stop()
        }
        else{
//            let urlString = Bundle.main.path(forResource: "Lobo Loco - Comming Back - Instrumental (ID 1355)", ofType: "mp3") // not needed
//            let urlSong = self.queriedSongs[self.currentSong].url // not needed
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
//                guard let urlString = urlString else { return } // not needed
            
//                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player = try AVAudioPlayer(data: self.queriedSongs[self.currentSong].getData())
                guard let player = player else { return }
                
                player.play()
            }
            catch {
                print("made it to the catch!")
            }
        }
    }
    
    /*
    // MARK: - Navigation
     
     
     let videoFile = object!["keyForVideoPFFile"] as! PFFile
     videoUrl = videoFile.url

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
