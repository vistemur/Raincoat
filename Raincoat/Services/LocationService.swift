//
//  LocationService.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 04.06.2023.
//

import CoreLocation

class LocationService: NSObject {
    
    static var shared = LocationService()
    private var locationManageer = CLLocationManager()
    private var location: CLLocation?
    private var locationHandler: ((CLLocation?) -> Void)?
    
    override init() {
        super.init()
        locationManageer.requestWhenInUseAuthorization()
        locationManageer.delegate = self
    }
    
    func getLocation(completion: @escaping (CLLocation?) -> Void) {
        if let location = location {
            completion(location)
        } else {
            locationHandler = completion
            switch locationManageer.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                locationHandler = completion
                locationManageer.requestLocation()
            case .notDetermined:
                locationHandler = completion
            default:
                completion(nil)
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        locationHandler?(location)
        locationHandler = nil
        locationManageer.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManageer.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorized, .authorizedAlways:
            locationManageer.requestLocation()
        default:
            self.location = nil
            locationHandler?(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
