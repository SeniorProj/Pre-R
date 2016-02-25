//
//  MapsViewController.swift
//  HouseCalls
//
//  Created by Albert Chan on 1/24/16.
//  Copyright © 2016 MarielSanchez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var coordinateOne: UILabel!
    @IBOutlet weak var maps: MKMapView!
    
    let locationManager = CLLocationManager()
    var doctorLocation = CLLocation(latitude:35.289239, longitude: -120.667206)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.maps.showsUserLocation = true
    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        var distanceMiles = doctorLocation.distanceFromLocation(location!) * 0.00062137119
        coordinateOne.text = NSString(format: "%.2f miles", distanceMiles) as String
        print(distanceMiles)
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span:MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.maps.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            coordinateOne.text = "Found user's location: \(location)"
            print("Found user's location: \(location)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        coordinateOne.text = "Failed: \(error.localizedDescription)"
        print("failed to find uer's location: \(error.localizedDescription)")
    }
    
    */
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
