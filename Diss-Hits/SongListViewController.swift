//
//  SongListViewController.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 4/27/21.
//

import UIKit
import AVFoundation
import Parse
import AlamofireImage

class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var songListView: UITableView!
    
    var songs = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songListView.dataSource = self
        songListView.delegate = self
        print("song list ***")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Songs")
        query.includeKeys(["songTitle", "author"])
//        query.limit = 20
        
        query.findObjectsInBackground { (songs, error) in
            if songs != nil {
                self.songs = songs!
                self.songListView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = songs[indexPath.row]
        
        let title = song["songTitle"] as! String
        cell.songLabel.text = title
        
        let artist = song["artist"] as! PFUser
//            print(artist)
            
//            cell.artistLabel.text = artist.username
        
        
        
//        let imageFile = song["albumCover"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)
        
//        cell.photoLabel.
        
//        print(song["albumCover"])
        
        if let imageFile = song["albumCover"] as? PFFileObject {
            
//            print(imageFile)
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.photoLabel.af.setImage(withURL: url)
        }
        
//        print(song)
        
        
        return cell
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
