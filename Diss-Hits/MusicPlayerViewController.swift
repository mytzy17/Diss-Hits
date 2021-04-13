//
//  MusicPlayerViewController.swift
//  Diss-Hits
//
//  Created by Josue Quintero on 4/13/21.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var playButton: UIButton!
    var player: AVAudioPlayer?
    
    
    @IBAction func playMusic(_ sender: Any) {
        print("playMusic")
        if let player = player, player.isPlaying {
            player.stop()
        }
        else{
            let urlString = Bundle.main.path(forResource: "Lobo Loco - Comming Back - Instrumental (ID 1355)", ofType: "mp3")
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else { return }
            
            
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
