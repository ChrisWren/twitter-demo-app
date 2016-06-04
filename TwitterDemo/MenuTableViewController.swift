//
//  MenuTableViewController.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/4/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

protocol MenuSelectDelegate: class {
  func didSelectMenuItem(menuItem: String)
}

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var options = ["Profile", "Timeline", "Mentions"]
  var delegate :MenuSelectDelegate?
  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.registerNib(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
      tableView.delegate = self
      tableView.dataSource = self
        // Do any additional setup after loading the view.
      tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.didSelectMenuItem(options[indexPath.row])
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView.init(frame: CGRectMake(0, 0, self.view.frame.width, 50))
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
    cell.menuLabel.text = options[indexPath.row]
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
