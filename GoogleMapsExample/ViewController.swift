//
//  ViewController.swift
//  GoogleMapsExample
//
//  Created by Роман Смоляков on 25/06/2019.
//  Copyright © 2019 Роман Смоляков. All rights reserved.
//

import UIKit
import GoogleMaps

//class ViewController: UIViewController {
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        let currencyCode = locale.currencyCode!
        
        print(currencySymbol)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 8.0)
        googleMap.camera = camera
        googleMap.settings.myLocationButton = true
        self.showMarker(position: googleMap.camera.target)
        
        var longitude :CLLocationDegrees = 41.0247
        var latitude :CLLocationDegrees = 40.522
        
        var location = CLLocation(latitude: latitude, longitude: longitude)
        print(location)
        
    
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    let pm = placemarks[0] as! CLPlacemark
                    print("--------------")
                    print(pm.locality)
                    print(pm.isoCountryCode)
                    
                    
                }
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue :CLLocationCoordinate2D = manager.location!.coordinate
        print("loc = \(locValue.latitude) - \(locValue.longitude)")
        let userLocation = locations.last
     
//        googleMap.camera = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!, longitude: userLocation!.coordinate.longitude, zoom: 8.0)
        googleMap.camera = GMSCameraPosition.camera(withTarget: userLocation!.coordinate, zoom: 10.0)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Delhi"
        marker.snippet = "Capital of India"
        marker.map = googleMap
        
    }

}






