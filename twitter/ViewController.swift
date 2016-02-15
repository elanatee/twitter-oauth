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
        twitterClient.sharedInstance.loginWithCompletion(){
            // pass in user if it exists or error if it exists
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                // if did login, take me to home timeline view
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle login error
            }
        }

    }
}

