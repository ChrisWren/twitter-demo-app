//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/1/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProfileImageTapDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var tableView: UITableView!
    var tweets = [Tweet]?()
  var refreshControl: UIRefreshControl?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      refreshControl = UIRefreshControl()
      refreshControl!.addTarget(self, action: #selector(refreshControlAction), forControlEvents: UIControlEvents.ValueChanged)
      
      navigationController?.delegate = self
      
      tableView.dataSource = self
      tableView.delegate = self
       tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 120
      fetchTweets()
      navigationItem.title = "Home"
      // Create left and right button for navigation item
      let leftButton =  UIBarButtonItem(title: "Log out", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(logOut))
      navigationItem.leftBarButtonItem = leftButton
      let rightButton = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(composeTweet))
      
      // Create two buttons for the navigation item
      
      navigationItem.rightBarButtonItem = rightButton
      // Make the navigation bar a subview of the current view controller
      //      navigationController?.navigationBar = navigationBar
      navigationController!.navigationBar.tintColor = UIColor.whiteColor()
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewWillAppear(animated: Bool) {
    tableView.insertSubview(refreshControl!, atIndex: 0)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = tweets?.count {
      return count
    } else {
      return 0
    }
  }
  
  func profileImageWasTapped(user: User) {
    let userProfileVC = UserProfileViewController()
    userProfileVC.user = user
    navigationController?.pushViewController(userProfileVC, animated: true)
  }
  
  func composeTweet() {
    let composeVC = TweetComposeViewController()
    composeVC.user = User.currentUser
    navigationController?.presentViewController(composeVC, animated: true, completion: nil)
  }
  
  func logOut() {
    User.currentUser = nil
    navigationController?.setViewControllers([LoginViewController()], animated: true)
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailVc = TweetDetailViewController()
    detailVc.tweet = tweets![indexPath.row]
    navigationController?.pushViewController(detailVc, animated: true)
  }
  
  func fetchTweets() {
    TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
      self.tweets = tweets
      self.tableView.reloadData()
      if (self.refreshControl != nil) {
        self.refreshControl!.endRefreshing()
      }
      }, failure: nil)
  }
  
  func refreshControlAction() {
    fetchTweets()
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let tweet = tweets![indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
    
    cell.tweetTextLabel.text = tweet.text
    if let timestamp = tweet.timestamp {
      cell.timestampLabel.text = tweet.timeAgoSince(timestamp)
    }
    cell.user = tweet.user
    
    cell.tweetUserNameLabel.text = tweet.user?.name
    
    cell.tweetProfileLabel.text = tweet.user?.screenname
    cell.profileImageView.setImageWithURL((tweet.user?.profileUrl)!, placeholderImage: nil)
    
    cell.delegate = self
    
    return cell
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
