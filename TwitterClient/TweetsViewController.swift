//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 2/23/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    var tweets : [Tweet]?
    
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 120
        
        
        
        let titleImageView = UIImageView.init(image: #imageLiteral(resourceName: "TwitterLogoBlue"))
        titleImageView.frame = CGRect(x:0, y:0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = titleImageView
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_refreshControl:)), for: UIControlEvents.valueChanged)
        tableview.insertSubview(refreshControl, at: 0)
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets) in
            
            
            self.tweets = tweets
            print(tweets)
            self.tableview.reloadData()
        }, failure: { (error) in
            TwitterClient.sharedInstance?.loginFailure!(error)
            print(error.localizedDescription)
        })
        
        
        if(TwitterClient.offset != 20) {
            TwitterClient.offset = 20
        }
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
        
        print(self.tweets?[indexPath.row])
            cell.tweet = self.tweets?[indexPath.row]
        
        
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
    
    func refreshControlAction(_refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets) in
            self.tweets = tweets
            print(tweets)
            self.tableview.reloadData()
            _refreshControl.endRefreshing()
        }, failure: { (error) in
            TwitterClient.sharedInstance?.loginFailure!(error)
            print(error.localizedDescription)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            //isMoreDataLoading = true
            
            let scrollViewContentHeight = tableview.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableview.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableview.isDragging) {
                print("reload\(TwitterClient.offset)")
                isMoreDataLoading = true
                loadMoreData()
                tableview.reloadData()
            }
        }
    }
        
    func loadMoreData() {
        print(TwitterClient.offset)
        if(TwitterClient.offset < 200) {
            TwitterClient.offset += 10
        }
        
        TwitterClient.sharedInstance?.loadMore(success: { (tweets) in
            
            self.tweets = tweets
            print(tweets)
            self.isMoreDataLoading = false
            self.tableview.reloadData()
        }, failure: { (error) in
            TwitterClient.sharedInstance?.loginFailure!(error)
            print(error.localizedDescription)
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
