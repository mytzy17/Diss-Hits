//
//  UserDetailsViewController.swift
//  Diss-Hits
//
//  Created by Mytzy Escalante on 4/26/21.
//

import UIKit
import Parse
import GoogleSignIn
import SwiftUI

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userSongs: UITableView!
    
    var songs = [PFObject]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSongs.delegate = self
        userSongs.dataSource = self
        
        userDeatails()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Songs")
//        print(PFUser.self)
//        print(PFUser.current())
        query.whereKey("artist", equalTo: PFUser.current()!)
        query.includeKey("songTitle")
        query.includeKey("artist")
        query.includeKey("albumCover")
//        query.limit = 20
        
        query.findObjectsInBackground { (songs, error) in
            if songs != nil {
                self.songs = songs!
                self.userSongs.reloadData()
            }
        }
        
//        print("oiadoiwajodiwjaoidwoaj")
//        self.userDeatails()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil);
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate;
        let loginView = main.instantiateViewController(identifier: "LoginView");
        GIDSignIn.sharedInstance()?.signOut();
        
        PFUser.logOut();
        delegate.window?.rootViewController = loginView;
    }
    
    func userDeatails() {
        
        let user = PFUser.current()!
        
        if let imageFile = user["userPfp"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            self.userProfileImage.af.setImage(withURL: url)
        }
        
        self.username.text = user["username"] as! String
        
        self.userBio.text = user["Bio"] as! String
        
//
//        let userData = appDelegate.getUserData();
//        let query = PFQuery(className:"_User");
//        query.whereKey("GID", equalTo: userData.userId);
//
//        query.findObjectsInBackground { (results: [PFObject]?, error: Error?)
//            in
//            if let error = error {
//                //could not find user
//                print(error.localizedDescription);
//            } else {
//
//                if let results = results {
//                    print(results)
//
////                    let username = results[0]["username"]
//
//                    if let imageFile = results[0]["userPfp"] as? PFFileObject {
//                        let urlString = imageFile.url!
//                        let url = URL(string: urlString)!
//
//                        self.userProfileImage.af.setImage(withURL: url)
//                    }
//
//                    self.username.text = results[0]["username"] as! String
//
//                    self.userBio.text = results[0]["Bio"] as! String
//
//
//               }
//
//            }
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = songs[indexPath.row]
        
        print(song)
        
        let title = song["songTitle"] as! String
        cell.songLabel.text = title
        
        let artist = song["artist"] as! PFUser
        cell.artistLabel.text = artist.username
        
        if let imageFile = song["albumCover"] as? PFFileObject {
            
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.photoLabel.af.setImage(withURL: url)
        }
        
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
