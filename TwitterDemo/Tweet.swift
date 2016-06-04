//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/1/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  
  var text: String?
  var timestamp: NSDate?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var profilePicUrl: NSURL?
  var screenname :String?
  var name :String?
  var user :User?
  
  init(dictionary: NSDictionary) {
    print(dictionary)
    text = dictionary["text"] as? String
    retweetCount = dictionary["retweet_count"] as? Int ?? 0
    favoritesCount = dictionary["favourites_count"] as? Int ?? 0
    user = User(dictionary: dictionary["user"] as! NSDictionary)
  }

  func timeAgoSince(date: NSDate) -> String {
    
    let calendar = NSCalendar.currentCalendar()
    let now = NSDate()
    let unitFlags: NSCalendarUnit = [.Second, .Minute, .Hour, .Day, .WeekOfYear, .Month, .Year]
    let components = calendar.components(unitFlags, fromDate: date, toDate: now, options: [])
    
    if components.year >= 2 {
      return "\(components.year)y"
    }
    
    if components.year >= 1 {
      return "1y"
    }
    
    if components.month >= 2 {
      return "\(components.month)m"
    }
    
    if components.month >= 1 {
      return "1m"
    }
    
    if components.weekOfYear >= 2 {
      return "\(components.weekOfYear)w"
    }
    
    if components.weekOfYear >= 1 {
      return "1w"
    }
    
    if components.day >= 2 {
      return "\(components.day)d"
    }
    
    if components.day >= 1 {
      return "1d"
    }
    
    if components.hour >= 2 {
      return "\(components.hour)h"
    }
    
    if components.hour >= 1 {
      return "1h"
    }
    
    if components.minute >= 2 {
      return "\(components.minute)m"
    }
    
    if components.minute >= 1 {
      return "1m"
    }
    
    if components.second >= 2 {
      return "\(components.second)s"
    }
    
    return "1s"
    
  }
  
  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }
    return tweets
  }

}
