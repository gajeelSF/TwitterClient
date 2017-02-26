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
    var timeStamp: Date?
    var retweetCount: Int? = 0
    var favoratesCount: Int? = 0
    
    var profileURL: NSURL?
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        
        
        
        user = dictionary["user"] as? NSDictionary
        favoratesCount = (user?["favourites_count"] as? Int) ?? 0
        
        let profileURLStrinig = user?["profile_image_url_https"] as? String
        
        if let profileURLString = profileURLStrinig    {
            profileURL = NSURL(string: profileURLString)
        }
        
        
        
        let timeStampString = dictionary["created_at"] as? String
       
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString) as Date?
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
