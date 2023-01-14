//
//  Model.swift
//  Weather
//
//  Created by Konstantin Bolgar-Danchenko on 23.11.2022.
//

import Foundation

struct WeatherResponse: Codable {
    let latitude: Float
    let longitude: Float
    let timezone: String
    let currently: CurrentWeather
    let hourly: HourlyWeather
    let daily: DailyWeather
}

struct CurrentWeather: Codable {
    let time: Int // header - date and time
    let summary: String // header - summary
    let icon: String
    let precipProbability: Float // header - precip probability
    let temperature: Double // header - current temp
    let windSpeed: Double // header - wind speed
    let cloudCover: Double // header - cloud cover
//    let precipIntensity: Int
//    let dewPoint: Double
//    let humidity: Double
//    let pressure: Double
//    let windGust: Double
//    let windBearing: Int
//    let uvIndex: Int
//    let visibility: Double
//    let ozone: Double
}

struct DailyWeather: Codable {
    let summary: String // состояние
    let icon: String
    let data: [DailyWeatherEntry]
}

// daily summary - temp
// daily summary - apparent temp
// daily summary - moonrise time
// daily summary - moonset time

struct DailyWeatherEntry: Codable {
    let time: Int // daily summary - date
    let summary: String // daily summary - summary
    let icon: String
    let sunriseTime: Int // header - sunrise time // daily summary - sunrise time
    let sunsetTime: Int // header - sunset time // daily summary - sunset time
    let moonPhase: Double // daily summary - moon phase
    let precipProbability: Float // daily summary - precip probability
    let precipType: String?
    let windSpeed: Double // daily summary - wind speed
    let windBearing: Int // daily summary - wind bearing
    let cloudCover: Double // daily summary - cloud cover
    let uvIndex: Int // daily summary - uv index
    let temperatureMin: Double // header - min temp
    let temperatureMax: Double // header - max temp
//    let precipIntensity: Float
//    let precipIntensityMax: Float
//    let temperatureHigh: Double
//    let temperatureHighTime: Int
//    let temperatureLow: Double
//    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
//    let apparentTemperatureHighTime: Int
//    let dewPoint: Double
//    let humidity: Double
//    let pressure: Double
//    let windGust: Double
//    let windGustTime: Int
//    let uvIndexTime: Int
//    let visibility: Double
//    let ozone: Double
//    let temperatureMinTime: Int
//    let temperatureMaxTime: Int
//    let apparentTemperatureMin: Double
//    let apparentTemperatureMinTime: Int
//    let apparentTemperatureMax: Double
//    let apparentTemperatureMaxTime: Int
}

struct HourlyWeather: Codable {
    let summary: String // 24 hours - summary
    let icon: String
    let data: [HourlyWeatherEntry]
}

struct HourlyWeatherEntry: Codable, Identifiable {
    
    let id = UUID()
    
    let time: Int // 24 hours - time
    let summary: String // 24 hours - summary
    let icon: String
    let precipProbability: Float // 24 hours - precip probability
    let precipType: String?
    let temperature: Double // 24 hours - temp
    let apparentTemperature: Double // 24 hours - apparent temp
    let windSpeed: Double // 24 hours - wind speed
    let windBearing: Int // 24 hours - wind bearing
    let cloudCover: Double // 24 hours - cloud cover
//    let precipIntensity: Float
//    let dewPoint: Double
//    let humidity: Double
//    let pressure: Double
//    let windGust: Double
//    let uvIndex: Int
//    let visibility: Double
//    let ozone: Double
}
