//
//  ViewController.swift
//  Rocket_Mapper
//
//  Created by Ian Rigg on 4/21/18.
//  Copyright © 2018 Ian Rigg. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let LaunchLibraryUrl: String = "https://launchlibrary.net/1.4/launch/"
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLocationManager()
        getLaunches()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: MapKit Handlers
    // General handler used for failed lookups
    func focusMap() {
        let span = MKCoordinateSpanMake(100.0, 100.0)
        let location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // Specific handler used for successful lookups
    func focusMap(on location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(40.0, 40.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: Network Handlers
    func getLaunches() {
        
        let parameters: Parameters? = [
            "next": 1
        ]
        
        Alamofire.request(LaunchLibraryUrl, method: .get, parameters: parameters!).responseJSON { response in
            guard (response.result.value != nil) else { return }
            guard (response.result.isSuccess) else { return }
        
            print("Did it")
            print(response.request!)

            let json = JSON(response.result.value!)

            print(json["launches"][0]["location"]["pads"][0]["longitude"])
            print(json["launches"][0]["location"]["pads"][0]["latitude"])
        }
    }
}


extension MapsViewController: CLLocationManagerDelegate {
    
    func prepareLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations were updated!!!")
        if let location = locations.first {
            focusMap(on: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            print("Found a location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Not able to find a location. \(error)")
        focusMap()
    }
}

