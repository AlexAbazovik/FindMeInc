import Foundation
import MapKit
import CoreLocation

class Geolocation: NSObject, CLLocationManagerDelegate{
    class var sharedInfo: Geolocation {
        struct My {
            static var instance = Geolocation()
        }
        return My.instance
    }
    
    let myLocationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func getUserGeolocation(){
        myLocationManager.delegate = self
        myLocationManager.requestAlwaysAuthorization()
        myLocationManager.requestWhenInUseAuthorization()
        myLocationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        currentLocation = manager.location!
        print(currentLocation!)
    }
}
