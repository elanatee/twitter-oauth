
//
//  TweetCell.swift
//  twitter
//
//  Created by Elana Tee on 2/16/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var isFavorited = false
    var isRetweeted = false
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
        twitterClient.sharedInstance.favorite(Int(tweetID!)!, params: nil) { (error) -> () in
            if !self.isFavorited {
                self.isFavorited = true
                sender.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Normal)
                if self.favoritesLabel.text == "0" {
                    self.favoritesLabel.hidden = false
                }
                self.favoritesLabel.text = String(self.tweet.favoriteCount! + 1)
            } else {
                self.isFavorited = false
                sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
                if self.favoritesLabel.text == "1" {
                    self.favoritesLabel.hidden = true
                }
                self.favoritesLabel.text = String(self.tweet.favoriteCount!)
            }
        }
    }

    @IBAction func onRetweet(sender: AnyObject) {
        twitterClient.sharedInstance.retweet(Int(tweetID!)!, params: nil) { (error) -> () in
            if !self.isRetweeted {
                self.isRetweeted = true
                sender.setImage(UIImage(named: "retweet-action-on-pressed_green"), forState: UIControlState.Normal)
                if self.retweetsLabel.text == "0" {
                    self.retweetsLabel.hidden = false
                }
                self.retweetsLabel.text = String(self.tweet.retweetCount! + 1)
            } else {
                self.isRetweeted = false
                sender.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
                if self.retweetsLabel.text == "1" {
                    self.retweetsLabel.hidden = true
                }
                self.retweetsLabel.text = String(self.tweet.retweetCount!)
            }
        }
    }
}
