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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        twitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        twitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemoElana://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got the request token")
        }) { (error: NSError!) -> Void in
            print("failed to get request token: \(error)")
        }
    }
}

