//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/1/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "zy9jaX31Ri1gpBCv3atFFenYC", consumerSecret: "vDwW7tRaW9cWcyRITLGyNSa0Gy7QGFjhAaV8Y65jVLO3tOEHVr")
  
  var loginFailure: ((NSError) -> ())?
  var loginSuccess: (() -> ())?
  
  func homeTimeline(success: ([Tweet]) ->  (), failure: ((NSError) -> ())?) {
    GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let tweets = response as! [NSDictionary]
      success(Tweet.tweetsWithArray(tweets))
    }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
      if let failure = failure {
        failure(error)
      }
    })
  }
  
  func tweet(status: String, success: (AnyObject?) ->  (), failure: ((NSError) -> ())?) {
    POST("1.1/statuses/update.json", parameters: ["status": status], success: { (task:NSURLSessionDataTask, response:AnyObject?) in
      success(response)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
        failure!(error)
    }
  }
  
  func login (success: () -> (), error: (NSError) -> ()) {
    self.loginSuccess = success
    TwitterClient.sharedInstance.deauthorize()
    TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
      let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
      UIApplication.sharedApplication().openURL(url!)
      
      }, failure: { (error: (NSError!)) in
        self.loginFailure?(error)
    })
  }
  
  func handleOpenUrl(url: NSURL) {
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (requestToken: BDBOAuth1Credential!) -> Void in
      self.currentAccount({ (user :User) in
        User.currentUser = user
        self.loginSuccess?()
        }, failure: { (error: NSError) in
          self.loginFailure?(error)
      })
      self.loginSuccess?()
      }, failure: { (error: (NSError!)) in
      self.loginFailure?(error)
    })
    
  }
  
  func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
    GET("1.1/account/verify_credentials.json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let user = User(dictionary: response as! NSDictionary)
      success(user)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        failure(error)
    })
  }



}
