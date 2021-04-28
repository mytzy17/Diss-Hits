//
//  ArtistPlaylistsViewController.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 4/27/21.
//

import UIKit
import AVFoundation
import Parse

class ArtistPlaylistsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var playlistView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistView.dataSource = self
        playlistView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "playlist #\(indexPath.row)"
        
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
