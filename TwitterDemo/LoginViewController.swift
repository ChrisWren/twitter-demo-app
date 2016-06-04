//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 5/31/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
        let nib = UINib.init(nibName: "LoginViewController", bundle: nil).instantiateWithOwner(self, options: nil)
      self.view = nib[0] as! UIView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onLoginButtonTap(sender: AnyObject) {
    let twitterClient = TwitterClient.sharedInstance
    twitterClient.login({
      self.navigationController?.setViewControllers([TweetsViewController()], animated: true)
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
