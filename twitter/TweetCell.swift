
//
//  TweetCell.swift
//  twitter
//
//  Created by Elana Tee on 2/16/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!

    var tweetID: String?
    
    var tweet: Tweet! {
        didSet {
            tweetID = tweet.id
            fullnameLabel.text = tweet.user!.name
            usernameLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text
            profileView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            retweetsLabel.text = String(tweet.retweetCount!)
            favoritesLabel.text = String(tweet.favoriteCount!)
            timePostedLabel.text = tweet.timeSince
            
            if favoritesLabel.text == "0" {
                favoritesLabel.hidden = true
            }
            if retweetsLabel.text == "0" {
                retweetsLabel.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileView.layer.cornerRadius = 5
        profileView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if tweet.isFavorited == false {
            twitterClient.sharedInstance.favorite(Int(tweetID!)!, params: nil) { (error) -> () in
                sender.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Normal)
                if self.favoritesLabel.text == "0" {
                    self.favoritesLabel.hidden = false
                }
                self.favoritesLabel.text = String(self.tweet.favoriteCount! + 1)
            }
        } else {
            // unfavorite if tweet is already favorited
            twitterClient.sharedInstance.unfavorite(Int(tweetID!)!)
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
            if self.favoritesLabel.text == "1" {
                self.favoritesLabel.hidden = true
            }
            self.favoritesLabel.text = String(self.tweet.favoriteCount!)
        }
        tweet.isFavorited = !tweet.isFavorited
    }

    @IBAction func onRetweet(sender: AnyObject) {
        if tweet.isRetweeted == false {
            twitterClient.sharedInstance.retweet(Int(tweetID!)!, params: nil) { (error) -> () in
                    sender.setImage(UIImage(named: "retweet-action-on-pressed_green"), forState: UIControlState.Normal)
                    if self.retweetsLabel.text == "0" {
                        self.retweetsLabel.hidden = false
                    }
                    self.retweetsLabel.text = String(self.tweet.retweetCount! + 1)
            }
        } else {
            // unretweet if already retweeted
            twitterClient.sharedInstance.unretweet(Int(tweetID!)!)
            sender.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
            if self.retweetsLabel.text == "1" {
                self.retweetsLabel.hidden = true
            }
            self.retweetsLabel.text = String(self.tweet.retweetCount!)
        }
        tweet.isRetweeted = !tweet.isRetweeted
    }
}

