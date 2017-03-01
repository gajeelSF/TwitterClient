//
//  User.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var screenName: String?
    var profileURL: NSURL?
    var tagline: String?
    var trueName: String?
    var userDescription : String?
    var backgroundURL: NSURL?
    
    var dictionary: NSDictionary?
    
    var postCount: Int?
    var followerCount: Int?
    var followingCount: Int?
    
    
    
    static let userLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString    {
            profileURL = NSURL(string: profileURLString)
        }
        
        let backgroundURLString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundURLString = backgroundURLString {
            backgroundURL = NSURL(string: backgroundURLString)
        }
        
        trueName = dictionary["screen_name"] as? String
        tagline = dictionary["descrption"] as? String
        
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        postCount = dictionary["statuses_count"] as? Int
        
        userDescription = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        get{
            if _currentUser == nil {
            let defaults = UserDefaults.standard
        
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData {
                let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
                }
 
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard

            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.setValue(data, forKey: "currentUserData")
            } else {
                defaults.setValue(nil, forKey: "currentUserData")
            }

            defaults.synchronize()
        }
    }
}
