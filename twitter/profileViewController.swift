//
//  profileViewController.swift
//  twitter
//
//  Created by Elana Tee on 2/22/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    var tweets: Tweet!
    var user: User?
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var coverPic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
        profilePic.setImageWithURL(NSURL(string:(tweets.user?.profileImageUrl)!)!)
        coverPic.setImageWithURL(NSURL(string:(tweets.user?.coverPhotoUrl)!)!)
        name.text = tweets.user?.name
        username.text = "@\(tweets.user!.screenname!)"
        

        if tweets.user!.following_count! < 1000 {
            followingCount.text = "\(tweets.user!.following_count!)"
        } else {
            followingCount.text = String(format: "%.2f", Double(tweets.user!.following_count!)/1000.0) + "k"
        }
        
        if tweets.user!.tweets_count! < 1000 {
            tweetsCount.text = "\(tweets.user!.tweets_count!)"
        } else {
            tweetsCount.text = String(format: "%.2f", Double(tweets.user!.tweets_count!)/1000.0) + "k"
            print(String(format: "%.2f", Double(tweets.user!.tweets_count!)/1000.0) + "k")
        }
        
        if tweets.user!.followers_count! < 1000 {
            followersCount.text = String(tweets.user!.followers_count!)
        } else {
            followersCount.text = String(format: "%.2f", Double(tweets.user!.followers_count!)/1000.0) + "k"
        }
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
