//
//  TweetCell.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var retweeted: Bool = false
    var favorated: Bool = false
    var tweet : Tweet! {
        didSet {
            //print(tweet.user)
            //print(tweet.text)
            
            let timeDiff = (Int)(Date().timeIntervalSince(tweet.timeStamp!))
            
            if(timeDiff < 60 ) {
                timestampLabel.text = "\(timeDiff)s"
            }
            else if(timeDiff < 3600) {
                timestampLabel.text = "\(timeDiff/60)m"
            }
            else if(timeDiff < 86400) {
                timestampLabel.text = "\(timeDiff/3600)h"
            }
            else {
                timestampLabel.text = "\(timeDiff/86400)d"
            }
            
            print(tweet.profileURL)
            profileImage.layer.cornerRadius = 10
            profileImage.clipsToBounds = true;
            if let profileURL = tweet?.profileURL {
                profileImage.setImageWith(profileURL as URL)
            }
            
            retweetLabel.text = tweet.retweetCount?.description
            favorateLabel.text = tweet.favoratesCount?.description
            
            contentLabel.text = tweet.text
            nameLabel.text = tweet.user?["name"] as! String
        }
    }
    @IBOutlet weak var favorateLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var favorateButton: UIButton!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavorate(_ sender: Any) {
        if(!favorated) {
            
            tweet.favoratesCount = tweet.favoratesCount! + 1
            favorated = true
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else {
            tweet.favoratesCount = tweet.favoratesCount! - 1
            favorated = false
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        favorateLabel.text = tweet.favoratesCount?.description
    }
    

    
    @IBAction func onRetweet(_ sender: Any) {
        if(!retweeted) {
            tweet.retweetCount = tweet.retweetCount! + 1
            retweeted = true
        }
        else {
            retweeted = false
            tweet.retweetCount = tweet.retweetCount! - 1
        }
        
        retweetLabel.text = tweet.retweetCount?.description
    }

}
