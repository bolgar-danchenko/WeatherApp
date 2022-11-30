//
//  WeatherManager.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation

class WeatherManager {
    
    static let shared = WeatherManager()
    
    var weatherResponse: WeatherResponse?
    
    var dailyModels = [DailyWeatherEntry]()
    var hourlyModels = [HourlyWeatherEntry]()
    var currentModels = [CurrentWeather]()
    
    func requestWeatherForLocation() {
        
        guard let currentLocation = LocationManager.shared.currentLocation else {
            print("Could not receive current location")
            return
        }
        
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)?exclude=[flags,minutely]"
        
        // Локация не работает
//        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/40.533349720551236,44.71910089563164?exclude=[flags,minutely]"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("Status code = \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            guard let data else {
                print("Could not receive data")
                return
            }
            
            var json: WeatherResponse?
            
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                print("Error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            self.weatherResponse = result
            
            let dailyEntries = result.daily.data
            
            self.dailyModels.append(contentsOf: dailyEntries)
            self.hourlyModels = result.hourly.data
            
            let currentEntries = result.currently
            self.currentModels.append(currentEntries)
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("WeatherReceived"), object: nil)
            
        }).resume()
    }
    
    func getCelsiusTemp(from temp: Double) -> Int {
        let celsiusTemp = (Int(temp) - 32) * 5 / 9
        return celsiusTemp
    }
}
