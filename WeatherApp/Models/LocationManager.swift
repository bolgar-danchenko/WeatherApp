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
    var userLocations = [CLLocation]()
    
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
                locationName += "\(locality), "
            }
            
            if let country = place.country {
                locationName += country
            }
            completion(locationName)
        }
    }
    
    func getLocationFromString(with address: String, completion: @escaping (_ location: CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else {
                completion(nil)
                return
            }
            if !strongSelf.userLocations.contains(where: { $0.coordinate == location.coordinate }) {
                strongSelf.userLocations.append(location)
            } else {
                print("Location already exists")
            }
            completion(location)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            
            guard let location = locations.first else { return }
            
            currentLocation = location
            userLocations.append(location)
            locationManager.stopUpdatingLocation()
            WeatherManager.shared.requestWeatherForLocation()
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
