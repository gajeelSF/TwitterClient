//
//  ComposeViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 2/28/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var content: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWith((User.currentUser?.profileURL)! as URL)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostClick(_ sender: Any) {
        TwitterClient.sharedInstance?.postTweet(content: content.text!)
        TweetsViewController.successfulTweeted = true
        self.performSegue(withIdentifier: "postFinishSegue", sender: nil)
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.performSegue(withIdentifier: "postFinishSegue", sender: nil)
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
