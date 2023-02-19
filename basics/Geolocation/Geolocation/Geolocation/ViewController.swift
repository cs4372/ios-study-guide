//
//  ViewController.swift
//  Geolocation
//
//  Created by Catherine Shing on 2/18/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressContent: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to allow View Controller to control the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latLabel.text = String(location.coordinate.latitude)
            longLabel.text = String(location.coordinate.longitude)
            courseLabel.text = String(location.course)
            speedLabel.text = String(location.speed)
            altLabel.text = String(location.altitude)

            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                var result = ""
                if let error = error {
                    print("Unable to Reverse Geocode Location (\(error))")
                    self.addressContent.text = "Unable to Find Address for Location"
                } else {
                    if let placemarks = placemarks, let placemark = placemarks.first {
                        if let name = placemark.name {
                            result+=name
                        }
                        
                        if let locality = placemark.locality {
                            result+=", \(locality)"
                        }
                        if let administrativeArea = placemark.administrativeArea {
                            result+=", \(administrativeArea)"
                        }
                        if let postalCode = placemark.postalCode {
                            result+=", \(postalCode)"
                        }
                        self.addressContent.text = result
                    }
                }
            }
        }
    }
}
