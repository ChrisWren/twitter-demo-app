//
//  User.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/1/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class User: NSObject {

  var name: String?
  var screenname: String?
  var profileUrl: NSURL?
  var profileBannerImageUrl: NSURL?
  var tagline: String?
  var dictionary: NSDictionary?
  var followersCount = 0
  var followingCount = 0
  
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    name = dictionary["name"] as? String
    if let screennameString = dictionary["screen_name"] as? String {
      screenname = "@" + screennameString
    }
    
    
    let profileUrlString = dictionary["profile_image_url_https"] as? String
    if let profileUrlString = profileUrlString {
      profileUrl = NSURL(string: profileUrlString)
    }
    
    let profileBannerUrlString = dictionary["profile_banner_url"] as? String
    if let profileBannerUrlString = profileBannerUrlString {
      profileBannerImageUrl = NSURL(string: profileBannerUrlString)
    }
    
    followersCount = dictionary["followers_count"] as! Int
    followingCount = dictionary["following"] as! Int
    
    
    tagline = dictionary["description"] as? String
    
  }
  
  static var _currentUser: User?
  class var currentUser: User? {
    set(user) {
      let defaults = NSUserDefaults.standardUserDefaults()
      if let user = user {
        let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
        defaults.setObject(data, forKey: "currentUser")
      } else {
        defaults.setObject(nil, forKey: "currentUser")
      }
      
      defaults.synchronize()
    }

    get {
      if _currentUser == nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userData = defaults.objectForKey("currentUser") as? NSData
        
        if let userData = userData {
          let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: [])
          _currentUser = User(dictionary: dictionary as! NSDictionary)        }
      }

      return _currentUser
    }
    
    
  }
  
}
