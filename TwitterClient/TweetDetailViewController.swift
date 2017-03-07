//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 3/6/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favorateButton: UIButton!
    @IBOutlet weak var retweetNumLabel: UILabel!
    @IBOutlet weak var favorateNumLabel: UILabel!
    
    var dictionary : Tweet? = nil
    var favorated : Bool?
    var retweeted : Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWith(dictionary?.profileURL as! URL)
        let name = dictionary?.user?["screen_name"] as! String
        nameLabel.text = dictionary?.user?["name"] as! String?
        
        realNameLabel.text = "@\(name)"
        contentLabel.text = dictionary?.text
        timeLabel.text = dictionary?.timeStamp?.description
        
        if(dictionary?.retweeted)! {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        
        if(dictionary?.favorated)! {
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else {
            favorateButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        
        retweetNumLabel.text = dictionary?.retweetCount?.description
        favorateNumLabel.text = dictionary?.favoratesCount?.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
