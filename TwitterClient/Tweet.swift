//
//  Tweet.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user : NSDictionary?
    
    var text : String?
    var timeStamp: NSDate?
    var retweetCount: Int? = 0
    var favoratesCount: Int? = 0
    
    var profileURL: URL?
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoratesCount = (dictionary["favorate_count"] as? Int) ?? 0
        
        user = dictionary["user"] as? NSDictionary
        
        if let user = user {
            profileURL = user["profile_image_url"] as? URL
        }
        
        let timeStampString = dictionary["created_at"] as? String
       
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString) as NSDate?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
