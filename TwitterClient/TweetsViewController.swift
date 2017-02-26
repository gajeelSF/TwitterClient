//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets) in
            
            self.tweets = tweets
        
            
        }, failure: { (error) in
            TwitterClient.sharedInstance?.loginFailure!(error)
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if let tweets = tweets {
            cell.tweet = tweets[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        else {
            return 0
        }
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
