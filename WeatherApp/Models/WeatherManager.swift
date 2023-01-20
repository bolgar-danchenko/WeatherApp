//
//  WeatherManager.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation
import CoreLocation

struct CityWeather {
    let cityName: String
    let location: CLLocation
    let dailyModels: [DailyWeatherEntry]
    let hourlyModels: [HourlyWeatherEntry]
    let currentModel: CurrentWeather
}

class WeatherManager {
    
    static let shared = WeatherManager()
    
    var cityWeatherList = [CityWeather]()
    
    func requestWeather(for location: CLLocation) {
        
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        
        let urlString = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)?exclude=[flags,minutely]"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            
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
            
            location.cityName { decodeResult in
                switch decodeResult {
                case .success(let success):
                    let cityWeather = CityWeather(cityName: success, location: location, dailyModels: dailyEntries, hourlyModels: result.hourly.data, currentModel: result.currently)
                    
                    CoreDataManager.shared.saveToCoreData(cityWeather: cityWeather)
                    CoreDataManager.shared.readFromCoreData { result in
                        self?.cityWeatherList = result
                        
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("WeatherReceived"), object: nil)
                    }
                case .failure(let failure):
                    print(failure)
                    break
                }
            }
        }).resume()
    }
    
    func updateCachedData(completion: @escaping (([CityWeather]) -> Void)) {
        CoreDataManager.shared.readFromCoreData { [weak self] result in
            result.forEach { cityWeather in
                self?.requestWeather(for: cityWeather.location)
            }
            completion(result)
        }
    }
    
    func configureSettings() {
        UserDefaults.standard.set("celsius", forKey: "temp-units")
        UserDefaults.standard.set("km", forKey: "speed-units")
        UserDefaults.standard.set("24h", forKey: "time-units")
        UserDefaults.standard.set(false, forKey: "isNotificationOn")
    }
    
    func getTemp(from temp: Double) -> Int {
        if UserDefaults.standard.value(forKey: "temp-units") as? String == "celsius" {
            let celsiusTemp = (Int(temp) - 32) * 5 / 9
            return celsiusTemp
        } else {
            return Int(temp)
        }
    }
    
    func getSpeed(from speed: Double) -> String {
        if UserDefaults.standard.value(forKey: "speed-units") as? String == "km" {
            let kmSpeed = Int(speed * 0.9144)
            return "\(kmSpeed) m/s"
        } else {
            return "\(Int(speed)) yd/s"
        }
    }
    
    func getTime(date: Int, format: String) -> String {
        let inputDate = Date(timeIntervalSince1970: Double(date))
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: inputDate)
    }
}
