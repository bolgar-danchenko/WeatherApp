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
}

struct DailyWeather: Codable {
    let summary: String // состояние
    let icon: String
    let data: [DailyWeatherEntry]
}

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
    let apparentTemperatureHigh: Double
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
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case precipProbability
        case precipType
        case temperature
        case apparentTemperature
        case windSpeed
        case windBearing
        case cloudCover
    }
}

enum MoonPhases: String {
    case newMoon = "New Moon"
    case quarter = "Quarter"
    case fullMoon = "Full Moon"
    case crescent = "Crescent"
}
