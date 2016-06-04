//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/1/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

protocol ProfileImageTapDelegate: class {
  func profileImageWasTapped(user: User)
}

class TweetTableViewCell: UITableViewCell {

  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var tweetProfileLabel: UILabel!
  @IBOutlet weak var tweetUserNameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  var user :User?
  
  var delegate :ProfileImageTapDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      let imageTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(TweetTableViewCell.onProfileImageTapped))
      profileImageView.addGestureRecognizer(imageTapGestureRecognizer)
      imageTapGestureRecognizer.delegate = self
      
    }
  
  func onProfileImageTapped() {
    delegate?.profileImageWasTapped(user!)
  }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
