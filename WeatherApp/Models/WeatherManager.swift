//
//  WeatherManager.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation
import CoreLocation

struct CityWeather {
    let location: CLLocation
    let dailyModels: [DailyWeatherEntry]
    let hourlyModels: [HourlyWeatherEntry]
    let currentModels: CurrentWeather
}

class WeatherManager {
    
    static let shared = WeatherManager()
    
    var cityWeatherList = [CityWeather]()
    
    func requestWeather(for location: CLLocation) {
        
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        
        let urlString = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)?exclude=[flags,minutely]"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Weather is currently unavailable. Please try again later.")
                print(error.localizedDescription)
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Weather is currently unavailable. Please try again later.")
                print("Status code = \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            guard let data else {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Weather is currently unavailable. Please try again later.")
                return
            }
            
            var json: WeatherResponse?
            
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Weather is currently unavailable. Please try again later.")
                print("Error: \(error)")
            }
            
            guard let result = json else {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Weather is currently unavailable. Please try again later.")
                return
            }
            
            let dailyEntries = result.daily.data
            
            let cityWeather = CityWeather(location: location, dailyModels: dailyEntries, hourlyModels: result.hourly.data, currentModels: result.currently)
            
            self.cityWeatherList.append(cityWeather)
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("WeatherReceived"), object: nil)
            
        }).resume()
    }
    
    func getCelsiusTemp(from temp: Double) -> Int {
        let celsiusTemp = (Int(temp) - 32) * 5 / 9
        return celsiusTemp
    }
    
    func getTime(date: Int, format: String) -> String {
        let inputDate = Date(timeIntervalSince1970: Double(date))
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: inputDate)
    }
}

enum TimeFormat: String {
    case time = "HH:mm" // 12:00
    case date = "d/MM" // 25/11
    case dateAndTime = "MMM d, h:mm a" // Nov 26, 3:12 PM
    case dayAndDate = "E, dd/MM" // Wed, 25/11
}
