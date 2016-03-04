//
//  Tweet.swift
//  twitter
//
//  Created by Elana Tee on 2/14/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var timePassed: Int?
    var timeSince: String!
    var favoriteCount: Int?
    var retweetCount: Int?
    var id: String?
    var isFavorited: Bool!
    var isRetweeted: Bool!
    
    init(dictionary: NSDictionary){
        id = String(dictionary["id"]!)
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let now = NSDate()
        let then = createdAt 
        timePassed = Int(now.timeIntervalSinceDate(then!))

        // creds for this function go to @dylan-james-smith from ccsf
        if timePassed >= 86400 {
            timeSince = String(timePassed! / 86400)+"d"
        }
        if (3600..<86400).contains(timePassed!) {
            timeSince = String(timePassed!/3600)+"h"
        }
        if (60..<3600).contains(timePassed!) {
            timeSince = String(timePassed!/60)+"m"
        }
        if timePassed < 60 {
            timeSince = String(timePassed!)+"s"
        }
    }
    
    // gives us an array of tweets
    // parses array of tweets
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        let tweet = Tweet(dictionary: dict)
        
        return tweet
    }
    
}
