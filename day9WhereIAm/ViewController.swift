//
//  ViewController.swift
//  day9WhereIAm
//
//  Created by Felix-ITS016 on 27/11/19.
//  Copyright © 2019 Felix. All rights reserved.
//

import UIKit
import  CoreLocation
import  MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    
    
    let locationManger = CLLocationManager()

    @IBAction func DetectLocationButton(_ sender: Any)
    {
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let currentLocation = locations.last!
       //print("Latitude =  and Longitude =  ",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
        print("Latitude = \(currentLocation.coordinate.latitude) and longitude = \(currentLocation.coordinate.longitude) ")
        
        /* Map view steps*/
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let  region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        MapView.setRegion(region, animated: true)
        
        /* To show Pin*/
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        MapView.addAnnotation(annotation)
       
        /* To Find Exact city  */
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            let  placemark = placemarks?.first!
            let title = placemark?.name
            annotation.title = title
            print(annotation.title!)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}



