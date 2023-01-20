//
//  CLLocationExtension.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 18.01.2023.
//

import Foundation
import CoreLocation

enum GeocoderError: Error {
    case notFound
}

extension CLLocation {
    
    func cityName(completion: @escaping ((Result<String, Error>) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(self) { placemarks, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let place = placemarks?.first else {
                completion(.failure(GeocoderError.notFound))
                return
            }
            
            var locationName = ""
            
            if let locality = place.locality {
                locationName += "\(locality), "
            }
            
            if let country = place.country {
                locationName += country
            }
            
            completion(.success(locationName))
        }
    }
    
    static func locationByCityName(address: String, completion: @escaping ((Result<CLLocation, Error>) -> Void)) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else { return }
            
            completion(.success(location))
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
