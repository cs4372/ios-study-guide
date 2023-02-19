//
//  ViewController.swift
//  Maps
//
//  Created by Catherine Shing on 2/18/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let latitude: CLLocationDegrees = 40.711
        let longitude: CLLocationDegrees = -74.009
        let latDelta: CLLocationDegrees = 0.005
        let lonDelta: CLLocationDegrees = 0.005
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Fulton Station"
        annotation.subtitle = "I'll go there"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)
        
        let longPressGestureRec = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        longPressGestureRec.minimumPressDuration = 2.0
        map.addGestureRecognizer(longPressGestureRec)
    }
    
    @objc func addAnnotation(press: UILongPressGestureRecognizer) {
        if press.state == .began {
            let location = press.location(in: map)
            let coordinates = map.convert(location, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            
            annotation.title = "My favorite place"
            annotation.subtitle = "YESS"
            
            map.addAnnotation(annotation)
        }
    }
}

