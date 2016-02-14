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
    class var sharedInstance: twitterClient {
        struct Static {
            static let instance = twitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
