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
        // print("song list ***")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Songs")
        query.includeKey("songTitle")
        query.includeKey("artist")
        query.includeKey("albumCover")
        query.limit = 20
        
        
        query.findObjectsInBackground { (songs, error) in
            if songs != nil {
                self.songs = songs!
                self.songListView.reloadData()
                // print(self.songs)
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
        cell.artistLabel.text = artist.username
        
        if let albumCover = song["albumCover"] as? PFFileObject{
            
            albumCover.getDataInBackground { (imageData, error) in
                if (error == nil) {
                    cell.photoLabel.image = UIImage(data: imageData!)
                }
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("loading new screen *******************")
        
        // Finding artist of selected song
        let cell = sender as! UITableViewCell
        let indexPath = songListView.indexPath(for: cell)!
        let song = songs[indexPath.row]
        let artistUser = song["artist"] as! PFUser
        
        // Pass data
        let detailsViewController = segue.destination as! ArtistActivityViewController
        detailsViewController.artist = artistUser
        
        // Animation to deselect
        songListView.deselectRow(at: indexPath, animated: true)
    }

}
