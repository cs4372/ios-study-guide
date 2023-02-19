## Geolocation

#### Steps to find user's current location 

1. Select main app from the left, go to General and Frameworks, Libraries and Embedded Content. Add CoreLocation.framework. Then, go to Build Phases, then Link Binary With Libraries. Verify that the CoreLocation.framework is present and status should be set to required. This framework will allow us to access all the location functions within iOS.
2. Edit info.plist and add the following 2 rows and provide a meaningful description:
- Privacy - Location Always Usage Description
- Privacy - Location When In Use Usage Description
3. Boilerplate code to request user's current location
```
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to allow View Controller to control the location manager and handle the requested user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        // Get Real-Time User Location Updates
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get latitude and longitude from current location

        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            ....
            
            ## show user location
            mapView.showsUserLocation = true
        }
    }
}
```

```
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get latitude and longitude from current location

        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let latDelta: CLLocationDegrees = 0.01
            let lonDelta: CLLocationDegrees = 0.01
            
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            // The latitude and longitude associated with a location
            let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
            mapView.setRegion(region, animated: true)

            ## Add pin annotation of current location in map 
            
            let annotation = MKPointAnnotation()
            annotation.title = "You are located in this area"
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)

            ## show user location
            mapView.showsUserLocation = true
        }
    }
}

```

#### Find user's physical location using latitude and longitude
- We hand the CLGeocoder class a set of coordinates, latitude and longitude, and ask it for the corresponding address, a physical location that has meaning to the user. 

```
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

```


Resources:
- https://www.abstractapi.com/guides/swift-geolocation
- https://www.advancedswift.com/user-location-in-swift/#get-a-user-s-location-once
- https://cocoacasts.com/reverse-geocoding-with-clgeocoder