//
//  User.swift
//  twitter
//
//  Created by Elana Tee on 2/14/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

// ???
var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    // for part 2
    var followers_count: Int?
    var following_count: Int?
    var coverPhotoUrl: String?
    var tweets_count: Int?
    
    // special constructor that accepts dict and deserializes dict into
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        // for part 2
        followers_count = dictionary["followers_count"] as? Int
        following_count = dictionary["friends_count"] as? Int
        coverPhotoUrl = dictionary["profile_background_image_url"] as? String
        tweets_count = dictionary["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        
        // clear access token, remove all my permissions
        twitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        // "tell anyone that's interested that this logout happened"
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    // create type property
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch {
        
                    }
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            // if we set a current user, we also want to "persist" it
            // serializing/deserializing objects?
            if _currentUser != nil {
                // try to store user
                do {
                    // if user isn't nil, change to json
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                    // store json here
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    // save/write to disk
                    NSUserDefaults.standardUserDefaults().synchronize()
                } catch {
                    print("error parsing json")

                } // end catch
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            } // end else
            NSUserDefaults.standardUserDefaults().synchronize()
        } // end set
    } // end class currentUser
}
