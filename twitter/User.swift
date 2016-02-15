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

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    // special constructor that accepts dict and deserializes dict into
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["descriptoin"] as? String
    }

    // create type property
    class var currentUser: User? {
        get {
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            // if we set a current user, we also want to "persist" it
            // serializing/deserializing objects?
            if _currentUser != nil {
                // try to store user
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                    
                    
                
                } catch {
                    print("error parsing json")
                } // end catch
            } // end if
        } // end set
    } // end class currentUser
}
