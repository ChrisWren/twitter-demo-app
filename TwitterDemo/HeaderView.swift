//
//  HeaderView.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/2/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class HeaderView: UIView {

  @IBOutlet var contentView: HeaderView!
  @IBOutlet weak var headerBackgroundImageView: UIImageView!
    /*
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initSubviews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }
  
  func initSubviews() {
    // standard initialization logic
    let nib = UINib(nibName: "HeaderView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)

  }
}
