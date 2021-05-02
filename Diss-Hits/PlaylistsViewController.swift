//
//  PlaylistViewController.swift
//  Diss-Hits
//
//  Created by Jesus Caballero on 4/28/21.
//

import UIKit
import Parse

class PlaylistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var playlistsTable: UITableView!
    
    var playlists = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistsTable.dataSource = self
        playlistsTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Playlists")
//        print(PFUser.self)
//        print(PFUser.current())
        query.whereKey("User", equalTo: PFUser.current())
//        query.limit = 20
        
        query.findObjectsInBackground { (songs, error) in
            if songs != nil {
                self.playlists = songs!
                self.playlistsTable.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell") as! PlaylistTableViewCell
        
        let playlist = playlists[indexPath.row]
        
        let playlistName = playlist["Name"] as! String
        cell.playlistName.text = playlistName
        
        if let imageFile = playlist["playlistCover"] as? PFFileObject {
            
//            print(imageFile)
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.playlistImage.af.setImage(withURL: url)
        }
        
        return cell
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let cell = sender as! UITableViewCell
//        let indexPath = playlistsTable.indexPath(for: cell)!
//        let playlist = playlists[indexPath.row]
        
        
        
        
        
//        let playlistViewController = segue.destination as! PlaylistViewController
        //        playlistViewController.songs = playlist[""] as! [PFObject]
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
