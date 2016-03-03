//
//  tweetsViewController.swift
//  twitter
//
//  Created by Elana Tee on 2/15/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class tweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        twitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        /*
        cell.profileView.userInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: "tappedProfileView:")
        tapped.numberOfTapsRequired = 1
        cell.profileView.addGestureRecognizer(tapped)
        */
        return cell
    }
    /*
    func tappedProfileView(gesture: UITapGestureRecognizer){
        performSegueWithIdentifier("toProfilePage", sender: nil)
    }
    */
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    /*
    @IBAction func segueToProfilePage(sender: AnyObject) {
        print("about to segue to profile page!")
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        let user = tweet.user
        
        let profilePageViewController = segue.destinationViewController as! profileViewController
        profilePageViewController.user = user
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toTweetPage" {
            print("going to tweet page!")
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweetViewController = segue.destinationViewController as! singleTweetViewController
            
            tweetViewController.tweets = tweets![(indexPath?.row)!]
        }
        else if segue.identifier == "toProfilePage" {
            print("going to profile page")
            
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let user = tweet.user
            
            let profilePageViewController = segue.destinationViewController as! profileViewController
            profilePageViewController.tweets = tweet
            profilePageViewController.user = user
        }
    }
    
}
