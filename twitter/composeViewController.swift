//
//  composeViewController.swift
//  twitter
//
//  Created by Elana Tee on 3/2/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class composeViewController: UIViewController, UITextViewDelegate {
    
    var tweets: Tweet!
    var user: User?
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetField: UITextView!
    
    var tweetToSend: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetField.delegate = self
        
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
        profilePic.setImageWithURL(NSURL(string:(User.currentUser?.profileImageUrl!)!)!)
        
        name.text = User.currentUser?.name!
        username.text = "@\(User.currentUser!.screenname!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        //let tweet = tweetToSend.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let tweet = tweetField.text
        
        twitterClient.sharedInstance.compose(tweet)
        dismissViewControllerAnimated(true, completion: {})
    }
    
    /*
    func textViewDidChange(textView: UITextView) {
        tweetToSend = tweetField.text
        print("updated")
    }
    */
    
    @IBAction func cancelTweet(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
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
