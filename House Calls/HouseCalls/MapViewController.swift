//
//  MapViewController.swift
//  HouseCalls
//
//  Created by Albert Chan on 2/28/16.
//  Copyright © 2016 MarielSanchez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var maps: MKMapView!
    @IBOutlet weak var distance: UILabel!
    
    let locationManager = CLLocationManager()
    var doctorLocation = CLLocation(latitude: 35.289239, longitude: -120.667206)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.maps.showsUserLocation = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let request = MKDirectionsRequest() //A
        let location = locations.last
      
        request.source = MKMapItem(placemark: MKPlacemark(coordinate:CLLocationCoordinate2D(latitude: manager.location!.coordinate.latitude, longitude: manager.location!.coordinate.longitude), addressDictionary: nil)) // A
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate:CLLocationCoordinate2D(latitude: 35.289239, longitude: -120.667206), addressDictionary: nil)) // A
      
        let directions = MKDirections(request: request) //A
        directions.calculateETAWithCompletionHandler { response, error in
           if error == nil {
              if let r = response {
               let result = r.expectedTravelTime
              }
           }
        }
      
        let distanceMiles = doctorLocation.distanceFromLocation(location!) * 0.000621371192237
        distance.text = NSString(format: "%.2f miles", distanceMiles) as String
        //print(distanceMiles)
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.maps.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
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
