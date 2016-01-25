//
//  OurViewController.swift
//  HouseCalls
//
//  Created by Mariel Sanchez on 11/18/15.
//  Copyright © 2015 MarielSanchez. All rights reserved.
//

import UIKit
import Parse
import Foundation

class OurViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var availButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the status of doctor every 10 seconds
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("getStatus"), userInfo: nil, repeats: true)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        do {
            var user = try PFQuery.getUserObjectWithId("dB4rAootm2")
            var status = user["availability"] as! String
            availButton.setTitle(status.uppercaseString, forState: .Normal)
        }
        catch {
           print("Did not get user")
        }
        
    }
    
    func getStatus() {
        do {
            var user = try PFQuery.getUserObjectWithId("dB4rAootm2")
            var status = user["availability"] as! String
            availButton.setTitle(status.uppercaseString, forState: .Normal)
            
        }
        catch {
            print("Did not get user")
        }
        //print("this is a check")
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
