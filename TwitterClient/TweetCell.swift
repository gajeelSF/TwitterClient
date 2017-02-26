//
//  TweetCell.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet : Tweet?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        profileImage.setImageWith((tweet?.profileURL)!)
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
