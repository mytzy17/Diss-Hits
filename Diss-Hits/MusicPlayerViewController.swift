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
    var queriedAlbumCovers = [PFFileObject]()
    var queriedNames = [String]()
    var currentSong = 0
    
    var lastPlayed = TimeInterval(0.0)
    var isInstantiated = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searcher(_ sender: Any) { // button
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
        
//        let input = "0tEAJSpk5W" // instead of an id it should be something else
        let input = searchField.text
        print("in the searcher")
        
        let query = PFQuery(className:"Songs")
        query.includeKeys(["artist", "lyrics", "songFile"])
        query.whereKey("songTitle", contains: input)

        let activate = UIAlertController(title: "This is what is available:", message: nil, preferredStyle: .actionSheet)
        
        //query for genre
        let queryByGenre = PFQuery(className: "Songs")
        queryByGenre.includeKeys(["artist", "lyrics", "songFile"])
        queryByGenre.whereKey("genre", contains: input)
        
        query.findObjectsInBackground() { (songs, error) in
            if error == nil {
                // Success!
                print(songs!)
                
                for song in songs!{
                    activate.addAction(UIAlertAction(title: song["songTitle"] as? String, style: .default, handler:{ action in
                        print(song["songTitle"]!)
                        self.queriedSongs.append(song["songFile"] as! PFFileObject)
                        self.queriedAlbumCovers.append(song["albumCover"] as! PFFileObject)
                        self.queriedNames.append(song["songTitle"] as! String)
                    }))
                }
            
            }
            else {
                print([error])
            }
        }
        
        queryByGenre.findObjectsInBackground() { (songs, error) in
            if error == nil {
                // Success!
                print(songs!)
            
                for song in songs!{
                    activate.addAction(UIAlertAction(title: song["songTitle"] as? String, style: .default, handler:{ action in
                        print(song["songTitle"]!)
                        self.queriedSongs.append(song["songFile"] as! PFFileObject)
                        self.queriedAlbumCovers.append(song["albumCover"] as! PFFileObject)
                    }))
                }
            }
            else {
                print([error])
            }
        }
        
        activate.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        activate.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(activate, animated: true)
        
    }
    
    
    @IBAction func backwardSong(_ sender: Any) {
        
        self.isInstantiated = false
        self.currentSong -= 1
        justPlay()
        
        print("backwardSong")
    }
    
    @IBAction func forwardSong(_ sender: Any) {
        
        self.isInstantiated = false
        self.currentSong += 1
        justPlay()
        
        print("forwardSong")
    }
    
    
    @IBOutlet weak var playButton: UIButton!
    var player: AVAudioPlayer?
    
    
    @IBAction func playMusic(_ sender: Any) {
        print("playMusic")
        
        justPlay()
    }
    
    func justPlay() {
        
        if(self.queriedSongs.count == 0){
            // throw a warning or somethign to notify
            return
        }
        
        if self.currentSong >= self.queriedSongs.count || self.currentSong < 0 {
            self.currentSong = 0
        }
        
        
        if let player = player, player.isPlaying {
            print("onIf")
            self.lastPlayed = player.currentTime
//            player.stop()
            player.pause()
            
            playButton.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
        }
        else if self.isInstantiated {
            player?.play()
            
            playButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        }
        
        
        if !self.isInstantiated{ // if its false here
            print("onElse")
//            let urlString = Bundle.main.path(forResource: "Lobo Loco - Comming Back - Instrumental (ID 1355)", ofType: "mp3") // not needed
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
//                guard let urlString = urlString else { return } // not needed
            
//                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString)) // file one
                player = try AVAudioPlayer(data: self.queriedSongs[self.currentSong].getData()) //db one
                guard let player = player else { return }
                
                player.play()
                
                imageView.image = UIImage(data: try self.queriedAlbumCovers[self.currentSong].getData())
                
                labelText.text = self.queriedNames[self.currentSong]
                
                self.isInstantiated = true
                
                playButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)

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
