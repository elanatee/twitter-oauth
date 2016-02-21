
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

    var tweet: Tweet! {
        didSet {
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

        // Configure the view for the selected state
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if !isFavorited {
            isFavorited = true
            sender.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Normal)
            if favoritesLabel.text == "0" {
                favoritesLabel.hidden = false
            }
            favoritesLabel.text = String(tweet.favoriteCount! + 1)
        } else {
            isFavorited = false
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
            if favoritesLabel.text == "1" {
                favoritesLabel.hidden = true
            }
            favoritesLabel.text = String(tweet.favoriteCount!)
        }
    }

    @IBAction func onRetweet(sender: AnyObject) {
        if !isRetweeted {
            isRetweeted = true
            sender.setImage(UIImage(named: "retweet-action-on-pressed_green"), forState: UIControlState.Normal)
            if retweetsLabel.text == "0" {
                retweetsLabel.hidden = false
            }
            retweetsLabel.text = String(tweet.retweetCount! + 1)
        } else {
            isRetweeted = false
            sender.setImage(UIImage(named: "retweet-action_default"), forState: UIControlState.Normal)
            if retweetsLabel.text == "1" {
                retweetsLabel.hidden = true
            }
            retweetsLabel.text = String(tweet.retweetCount!)
        }
    }
}
