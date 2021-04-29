//
//  SongCell.swift
//  Diss-Hits
//
//  Created by Jennifer Lopez on 4/27/21.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var photoLabel: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
