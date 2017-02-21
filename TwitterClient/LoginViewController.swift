//
//  LoginViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 2/21/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {

        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "k258rh8AYrn9LowdWzi3b6NEG", consumerSecret: "QF3aruCufi2MUH0QxXjNSYVfv9vBtAMJFc0LA5C85hBxbZzxkx")

        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterclient://oauth") as URL!, scope: nil, success:
            { (requestToken) in
            
                print("I get the token")
                
                if let token = requestToken?.token {
                    let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                
                    UIApplication.shared.open(url as URL)
                }
        }, failure: { (error) in
            print("error")
        })
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
