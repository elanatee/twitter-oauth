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
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        // home timeline endpoint
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            // print("home timeline: \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
            print("error getting home timeline")
            completion(tweets: nil, error: error)
        })
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
                
                // logging in
                let user = User(dictionary: response as! NSDictionary)

                // persists user as current user
                User.currentUser = user
                
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })

            
        }) {
           (error: NSError!) -> Void in
           print("failed to receive access token")
        }
    }

    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("retweeted tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("tweet not retweeted")
                completion(error: error)
            }
        )
    }
    
    func unretweet(id: Int) {
        POST("1.1/statuses/unretweet/\(id).json", parameters: nil,  success: { (operation, response) -> Void in
            print("succesfully untweeted")
            }, failure: { (operation, error) -> Void in
                print("error untweeting")
        })
    }
    
    
    func favorite(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("favorited tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("tweet not favorited")
                completion(error: error)
            }
        )
    }
    
    func unfavorite(id: Int) {
        POST("1.1/favorites/destroy.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("succesfully unfavorited")
            
            }, failure: { (operation, error) -> Void in
                print("error unfavoriting")
        })
    }

    /*
    func compose(tweet: String, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/update.json?status=\(tweet)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("just tweeted \(tweet)!")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }*/
    
    func compose(status: String) {
        POST("1.1/statuses/update.json", parameters: ["status": status], success: { (operation, response) -> Void in
            print("succesfully tweeted")
            
            }, failure: { (operation, error) -> Void in
                print("error tweeting")
        })
    }
}
