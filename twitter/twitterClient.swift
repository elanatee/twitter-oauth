//
//  twitterClient.swift
//  twitter
//
//  Created by Elana Tee on 2/10/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "TT38rJdvoO3YAwQB2v8hVazWX"
let twitterConsumerSecret = "F7kCtZDwpnS793aTgi5hd2HQD9cHaQtjpiPTMOsuIFb1OlHIra"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class twitterClient: BDBOAuth1SessionManager {
    
    // not sure what this variable does
    // "holds the closure until we're ready to use it"?
    // this var may or may not be there - optional
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: twitterClient {
        struct Static {
            static let instance = twitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    // initiate login process
    // if succeeds or fails, call completion block with either user or error
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        // fetch request token and redirect to authorization page  
        twitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        twitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "elanatwitterdemo://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            print("got the request token")
            
            // let twitter know we're authorized to send user here
            let authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) {
                (error: NSError!) -> Void in
                print("failed to get request token: \(error)")
                // if failure, call login completion and give it a nil user and an error
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    // handle the open url
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            print("got the access token!")
            
            // gets access token, account credentials, then gets current user
            twitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            twitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                // print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            // home timeline endpoint
            twitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                // print("home timeline: \(response)")
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    print("text: \(tweet.text), created: \(tweet.createdAtString)")
                }
                }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
            })
            
            }) {
                (error: NSError!) -> Void in
                print("failed to receive access token")
        }
    }
    
}
