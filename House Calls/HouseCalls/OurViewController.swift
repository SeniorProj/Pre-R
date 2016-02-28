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
import LBBlurredImage

class OurViewController: UIViewController {
    
    var backgroundImageView :UIImageView!
    var blurredImageView :UIImageView!
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var availButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Round out button corners
        self.requestButton.layer.cornerRadius = 5.0
        self.availButton.layer.cornerRadius = 5.0
        self.distanceButton.layer.cornerRadius = 5.0

        // Set the blurred background image
        if let image = UIImage(named: "downtown.jpg") {
            // initialize the value of imageView with a CGRectZero, resize it later
            self.backgroundImageView = UIImageView(frame: CGRectZero)
            
            // set the appropriate contentMode and add the image to your imageView property
            self.backgroundImageView.contentMode = .ScaleAspectFill
            self.backgroundImageView.image = image
            

            self.blurredImageView = UIImageView(frame: CGRectZero)
            self.blurredImageView.contentMode = .ScaleAspectFill
            self.blurredImageView.alpha = 0.2
            self.blurredImageView.setImageToBlur(image, blurRadius:30.0, completionBlock:nil)

            // add the views to your view hierarchy
            self.view.addSubview(backgroundImageView)
            self.view.addSubview(blurredImageView)
            self.view.sendSubviewToBack(blurredImageView)
            self.view.sendSubviewToBack(backgroundImageView)
        }
            
        else {
            print("There was no such image")
        }
        
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

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //set the frame of your imageView here to automatically adopt screen size changes (e.g. by rotation or splitscreen)
        self.backgroundImageView.frame = self.view.bounds
        self.blurredImageView.frame = self.view.bounds;
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        
        
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
