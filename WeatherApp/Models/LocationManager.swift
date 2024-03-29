//
//  LocationManager.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation
import UIKit
import CoreLocation

struct City {
    let cityName: String
    let location: CLLocation
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var newLocationHandler: ((CLLocation) -> Void)?
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func isLocationAllowed() -> Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
    }
    
    func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            if let error = error {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Something went wrong. Please try again later.")
                print(error.localizedDescription)
            }
            
            guard let place = placemarks?.first else {
                completion(nil)
                return
            }
            
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
    
    func getLocationFromString(with address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            
            if let error = error {
                AlertModel.shared.okActionAlert(title: "Attention", message: "This location is unavailable")
                print(error.localizedDescription)
            }
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else { return }
            
            self?.newLocationHandler?(location)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty {
            guard let location = locations.first else {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Unable to determine your location")
                return
            }
            locationManager.stopUpdatingLocation()
            WeatherManager.shared.requestWeather(for: location)
            newLocationHandler?(location)
        }
    }
}


