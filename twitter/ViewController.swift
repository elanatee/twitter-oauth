//
//  ViewController.swift
//  twitter
//
//  Created by Elana Tee on 2/10/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onLogin(sender: AnyObject) {
        twitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        twitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemoElana://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
        }) {
            (error: NSError!) -> Void in
            print("Failed to get request token")
        }
    }
}

