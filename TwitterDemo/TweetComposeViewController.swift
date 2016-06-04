//
//  TweetComposeViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/2/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class TweetComposeViewController: UIViewController, UINavigationBarDelegate {

    var user :User?
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var userScreenNameLabel: UILabel!
  
  @IBOutlet weak var tweetTextView: UITextView!
  @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64)) // Offset by 20 pixels vertically to take the status bar into
      navigationBar.delegate = self
      let navigationItem = UINavigationItem()
      navigationItem.title = "Compose"
      // Create left and right button for navigation item
      let leftButton =  UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(cancel))
      navigationItem.leftBarButtonItem = leftButton
      let rightButton = UIBarButtonItem(title: "Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(tweet))
      
      // Create two buttons for the navigation item
      
      navigationItem.rightBarButtonItem = rightButton
      navigationBar.barTintColor = UIColor.hx_colorWithHexString("#55acee")
      navigationBar.tintColor = UIColor.whiteColor()
      navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
      
      // Make the navigation bar a subview of the current view controller
      navigationBar.items = [navigationItem]
      self.view.insertSubview(navigationBar, atIndex: 0)
      
      if let profileUrl = user?.profileUrl {
        userProfileImageView.setImageWithURL(profileUrl, placeholderImage: nil)
      }
      
      userScreenNameLabel.text = user?.screenname
      userNameLabel.text = user?.name
      tweetTextView.becomeFirstResponder()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func tweet() {
    TwitterClient.sharedInstance.tweet(tweetTextView.text, success: { (response: AnyObject?) in
      self.dismissViewControllerAnimated(true, completion: nil)
    }) { (error: NSError) in
        print(error)
    }
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
