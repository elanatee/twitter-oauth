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
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
        
        profilePic.setImageWithURL(NSURL(string:(tweets.user?.profileImageUrl)!)!)
        fullnameLabel.text = tweets.user?.name!
        usernameLabel.text = "@\(tweets!.user!.screenname!)"
        tweetLabel.text = tweets.text!
        retweetsLabel.text = String(tweets.retweetCount!)
        favoritesLabel.text = String(tweets.favoriteCount!)
        
        if favoritesLabel.text == "1" {
            favoriteLabel.text = "FAVORITE"
        }
        if retweetsLabel.text == "1" {
            retweetLabel.text = "RETWEET"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        */
        
        let tweet = tweets!
        let user = tweet.user
        
        let composevc = segue.destinationViewController as! composeViewController
        composevc.tweets = tweet
        composevc.user = user
        
    }
  

}
