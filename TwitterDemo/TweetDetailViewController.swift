//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/2/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
    var tweet :Tweet?

  var retweeted = false
  var liked = false
  @IBOutlet weak var replyImageView: UIImageView!
  @IBOutlet weak var retweetImageView: UIImageView!
  @IBOutlet weak var heartImageView: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var timeagoLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "Tweet"
      // Make the navigation bar a subview of the current view controller
      //      navigationController?.navigationBar = navigationBar
      navigationController!.navigationBar.tintColor = UIColor.whiteColor()
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
      
      tweetTextLabel.text = tweet?.text
//      timeagoLabel.text = tweet?.timeAgoSince(tweet.timestamp!)
      usernameLabel.text = tweet?.user?.name
      screennameLabel.text = tweet?.user?.screenname
      profileImageView.setImageWithURL((tweet?.user?.profileUrl)!)
      if let favoritesCount = tweet?.favoritesCount {
        favoriteCountLabel.text = String(favoritesCount)
      }
      
      if let retweetCount = tweet?.retweetCount{
        retweetCountLabel.text = String(retweetCount)
      }
      
      
      

        // Do any additional setup after loading the view.
    }
  @IBAction func onTapHeartIcon(sender: UITapGestureRecognizer) {
    liked = !liked
    if liked {
      heartImageView.image = UIImage.init(named: "heart_selected")
    } else {
      heartImageView.image = UIImage.init(named: "heart")
    }
  }
  @IBAction func onRetweetTapped(sender: AnyObject) {
    retweeted = !retweeted
    if retweeted {
      retweetImageView.image = UIImage.init(named: "retweet_selected")
    } else {
      retweetImageView.image = UIImage.init(named: "retweet")
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
