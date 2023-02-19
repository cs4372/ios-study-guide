## Maps

#### Display a specific region in the map
#### Add annotations to map
#### Long Press Gesture Recgonizer (Detect taps and add annotations)

```
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude: CLLocationDegrees = 40.71
        let longitude: CLLocationDegrees = -74.01

        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01

        /*
        use the delta values in this structure to indicate the desired zoom level of the map
        */
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

        // The latitude and longitude associated with a location
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)

        // Add annotations to map 
        let annotation = MKPointAnnotation()
        annotation.title = "Fulton Station"
        annotation.subtitle = "I'll go there"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)

        // Long Press Gesture Recgonizer (Detect taps and add annotations)

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

```

Resources:
- https://johncodeos.com/how-to-display-location-and-routes-with-corelocation-mapkit-using-swift/

Swift UI:
- https://www.createwithswift.com/using-mapkit-with-swiftui/