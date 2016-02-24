//
//  SingleTweetViewController.swift
//  twitter
//
//  Created by Elana Tee on 2/22/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class singleTweetViewController: UIViewController {

    var tweets: Tweet!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
        profilePic.setImageWithURL(NSURL(string:(tweets.user?.profileImageUrl)!)!)
        fullnameLabel.text = tweets.user?.name!
        usernameLabel.text = "@\(tweets!.user!.screenname!)"
        tweetLabel.text = tweets.text!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
  */  

}
