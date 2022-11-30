//
//  LocationManager.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var timeZone: String?
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                print(error?.localizedDescription ?? "No errors")
                completion(nil)
                return }
            
            var locationName = ""
            
            if let locality = place.locality {
                locationName += locality
            }
            
            if let country = place.country {
                locationName += ", \(country)"
            }
            completion(locationName)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            WeatherManager.shared.requestWeatherForLocation()
        }
    }
}
