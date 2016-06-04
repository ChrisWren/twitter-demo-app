//
//  MenuViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/4/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, MenuSelectDelegate {

  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var contentView: UIView!
  
  var menuTableViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      menuView.addSubview(menuTableViewController.view)
    }
  }
  
  private var activeViewController: UIViewController? {
    didSet {
      removeInactiveViewController(oldValue)
      updateActiveViewController()
    }
  }
  
  func didSelectMenuItem(menuItem: String) {
    switch menuItem {
    case "Profile":
      let userProfileVc = UserProfileViewController()
      userProfileVc.user = User.currentUser
      let navVC = UINavigationController(rootViewController: userProfileVc)
      navVC.navigationBar.barTintColor = UIColor.hx_colorWithHexString("#55acee")
      activeViewController = navVC
    case "Timeline":
      let tweetsVc = TweetsViewController()
      let navVC = UINavigationController(rootViewController: tweetsVc)
      navVC.navigationBar.barTintColor = UIColor.hx_colorWithHexString("#55acee")
      activeViewController = navVC
    case "Mentions":
      let mentionsVc = MentionsViewController()
      activeViewController = mentionsVc
    default: break
    }
    UIView.animateWithDuration(0.3, animations: {
      self.leftMarginConstraint.constant = 0
    })
  }
  
  private func removeInactiveViewController(inactiveViewController: UIViewController?) {
    if let inActiveVC = inactiveViewController {
      // call before removing child view controller's view from hierarchy
      inActiveVC.willMoveToParentViewController(nil)
      
      inActiveVC.view.removeFromSuperview()
      
      // call after removing child view controller's view from hierarchy
      inActiveVC.removeFromParentViewController()
    }
  }
  
  private func updateActiveViewController() {
    if let activeVC = activeViewController {
      // call before adding child view controller's view as subview
      addChildViewController(activeVC)
      
      activeVC.view.frame = contentView.bounds
      contentView.addSubview(activeVC.view)
      
      // call before adding child view controller's view as subview
      activeVC.didMoveToParentViewController(self)
    }
  }
  
  var originalLeftMargin :CGFloat = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      var vc = UIViewController()
      if User.currentUser != nil {
        print("There is a current user")
        vc = TweetsViewController()
      } else {
        print("There is no current user")
        vc = LoginViewController()
      }
      
      view.layoutIfNeeded()
      
      
      let menuTableVc = MenuTableViewController()
      menuTableVc.delegate = self
      addChildViewController(menuTableVc)
      
      menuTableVc.view.frame = menuView.bounds
      // call before adding child view controller's view as subview
      menuTableVc.didMoveToParentViewController(self)
      menuView.addSubview(menuTableVc.view)
      
      let navVC = UINavigationController(rootViewController: vc)
      navVC.navigationBar.barTintColor = UIColor.hx_colorWithHexString("#55acee")
      activeViewController = navVC

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onPanGesture(sender: AnyObject) {
    let translation = sender.translationInView(view)
    let velocity = sender.velocityInView(view)

    if sender.state == UIGestureRecognizerState.Began {
      originalLeftMargin = leftMarginConstraint.constant
    } else if sender.state == UIGestureRecognizerState.Changed {
      if translation.x > 0 {
        leftMarginConstraint.constant = originalLeftMargin + translation.x
      }
    } else if sender.state == UIGestureRecognizerState.Ended {
      
      UIView.animateWithDuration(0.3, animations: {
        if (velocity.x > 0) {
          self.leftMarginConstraint.constant = self.view.frame.size.width - 50
        } else {
          self.leftMarginConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
      })
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
