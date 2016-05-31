//
//  OurViewController.swift
//  HouseCalls
//
//  Created by Mariel Sanchez on 11/18/15.
//  Copyright © 2015 MarielSanchez. All rights reserved.
//

import UIKit
import Foundation
import LBBlurredImage
import MapKit
import CoreLocation

class OurViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var backgroundImageView :UIImageView!
    var blurredImageView :UIImageView!
    var maps :MKMapView!
    var doctorLocation = CLLocation(latitude: 35.289239, longitude: -120.667206)
    
    let locationManager = CLLocationManager()
    
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

        self.availButton.titleLabel?.adjustsFontSizeToFitWidth = true

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
            //var user = try PFQuery.getUserObjectWithId("dB4rAootm2")
            //var status = user["availability"] as! String
            //availButton.setTitle(status.uppercaseString, forState: .Normal)
        }
        catch {
           print("Did not get user")
        }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //set the frame of your imageView here to automatically adopt screen size changes (e.g. by rotation or splitscreen)
        self.backgroundImageView.frame = self.view.bounds
        self.blurredImageView.frame = self.view.bounds;
    }
    
    func getStatus() {
        do {
            //var user = try PFQuery.getUserObjectWithId("dB4rAootm2")
            //var status = user["availability"] as! String
            //availButton.setTitle(status.uppercaseString, forState: .Normal)
            
        }
        catch {
            print("Did not get user")
        }
        //print("this is a check")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let distanceMiles = 7 + (doctorLocation.distanceFromLocation(location!) * 0.000621371192237) * 2
        distanceButton.setTitle(NSString(format: "%.2f minutes", distanceMiles) as String, forState: .Normal)
        print(distanceMiles)
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
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
