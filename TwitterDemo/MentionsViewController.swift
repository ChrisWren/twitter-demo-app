//
//  MentionsViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/4/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  var refreshControl: UIRefreshControl?
  var tweets = [Tweet]?()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 120
      fetchTweets()
      navigationItem.title = "Mentions"
        // Do any additional setup after loading the view.
      refreshControl = UIRefreshControl()
      refreshControl!.addTarget(self, action: #selector(fetchTweets), forControlEvents: UIControlEvents.ValueChanged)
      navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
  
  func fetchTweets() {
    TwitterClient.sharedInstance.mentions({ (tweets: [Tweet]) in
      self.tweets = tweets
      self.tableView.reloadData()
      if (self.refreshControl != nil) {
        self.refreshControl!.endRefreshing()
      }
      }, failure: nil)
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
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = tweets?.count {
      return count
    } else {
      return 0
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
