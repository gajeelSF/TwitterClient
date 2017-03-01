//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static var offset = 20
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "k258rh8AYrn9LowdWzi3b6NEG", consumerSecret: "QF3aruCufi2MUH0QxXjNSYVfv9vBtAMJFc0LA5C85hBxbZzxkx")
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterclient://oauth") as URL!, scope: nil, success:
            { (requestToken) in
                if let token = requestToken?.token {
                    let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                    
                    UIApplication.shared.open(url as URL)
                }
        }, failure: { (error) in
            print("error")
            self.loginFailure?(error!)
        })
    }
    
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userLogoutNotification), object: nil)
    }
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error)
            })
        }, failure: { (error) in
            print("access error")
            self.loginFailure?(error!)
        })
        
        

    }
    
    func homeTimeLine(success:  @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
        }, failure: { (task, error) in
            print(error.localizedDescription)
        })
       
    }
    
    func loadMore(success:  @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {

        get("1.1/statuses/home_timeline.json?count=\(TwitterClient.offset)", parameters: nil, progress: nil, success: { (task, response) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
        }, failure: { (task, error) in
            print(error.localizedDescription)
        })
        
    }
    
    func currentAccount(success: @escaping (User) -> (), failure:@escaping (Error)-> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
           
        }, failure: { (task, error) in
            
            print(error.localizedDescription)
            
        })
    }
    
    func postTweet(content: String) {
        let parameters = ["status": content]
        post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (task, response) in
            print("oh successfully post!")
        }) { (task, error) in
            
            print(error.localizedDescription)
        }
    }
}
