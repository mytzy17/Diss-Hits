//
//  SongListViewController.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 4/27/21.
//

import UIKit
import AVFoundation
import Parse

class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var songListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songListView.dataSource = self
        songListView.delegate = self
        print("hello ***")

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
            
        cell.songLabel.text = "Song name #\(indexPath.row)"
        cell.artistLabel.text = "Artist #\(indexPath.row)"
        
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
