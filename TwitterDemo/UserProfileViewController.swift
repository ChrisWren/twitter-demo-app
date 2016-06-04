//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/2/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

  var user :User?
  @IBOutlet weak var userProfileImageView: UIImageView!
  
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var tweetCountLabel: UILabel!
  @IBOutlet weak var followersLabel: UILabel!
  @IBOutlet weak var followingLabel: UILabel!
  @IBOutlet weak var headerView: HeaderView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = user?.name
      navigationController!.navigationBar.tintColor = UIColor.whiteColor()
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
      if let backgroundUrl = user?.profileBannerImageUrl {
        headerView?.headerBackgroundImageView.setImageWithURL(backgroundUrl)
        view.addSubview(headerView!)
        
      }
      if let followerCount = user?.followersCount {
        followersLabel.text = String(followerCount)
      }
      
      if let followingCount = user?.followingCount {
        followingLabel.text = String(followingCount)
      }
      
      screennameLabel.text = "@" + (user?.screenname)!
      userProfileImageView.setImageWithURL((user?.profileUrl)!)
      
      
      
        // Do any additional setup after loading the view.
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
