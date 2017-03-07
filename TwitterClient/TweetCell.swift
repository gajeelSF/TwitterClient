//
//  TweetCell.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

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
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var favorateButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavorate(_ sender: Any) {
        if(!tweet.favorated!) {
            tweet.favorated = true
            TwitterClient.sharedInstance?.favorate(ID: tweet.ID!)
            tweet.favoratesCount = tweet.favoratesCount! + 1
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else {
            tweet.favorated = false
            TwitterClient.sharedInstance?.unfavorate(ID: tweet.ID!)
            tweet.favoratesCount = tweet.favoratesCount! - 1
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        favorateLabel.text = tweet.favoratesCount?.description
    }
    

    
    @IBAction func onRetweet(_ sender: Any) {
        if(!tweet.retweeted!) {
            tweet.retweeted = true
            tweet.retweetCount = tweet.retweetCount! + 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else {
            tweet.retweeted = false
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            tweet.retweetCount = tweet.retweetCount! - 1
        }
        
        retweetLabel.text = tweet.retweetCount?.description
    }

}
