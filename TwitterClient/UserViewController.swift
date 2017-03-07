//
//  UserViewController.swift
//  TwitterClient
//
//  Created by SongYuda on 2/28/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user :User?
    @IBOutlet weak var userImage: UIImageView!
    

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var trueNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(self)
    
        
        
             userImage.setImageWith((user?.profileURL)! as URL)
        if let backgroundURL = user?.backgroundURL {
            backgroundImage.setImageWith(backgroundURL as URL)
        }
        nameLabel.text = user?.name
        if let userTrueName = user?.trueName {
            trueNameLabel.text = "@\(userTrueName)"
        }

        descriptionLabel.text = user?.userDescription
        
        print(user?.description)
        
        
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
