//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 18.01.2023.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

final class CoreDataManager {

    // MARK: - Setup CoreData
    
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var viewContext: NSManagedObjectContext {
        if let context = self.appDelegate?.persistentContainer.viewContext {
            return context
        } else {
            preconditionFailure()
        }
    }
    
    // MARK: - Save
    
    public func saveToCoreData(cityWeather: CityWeather) {

        removeOldData(cityName: cityWeather.cityName)

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CityWeather", in: viewContext) else { return }

        let city = CityWeatherEntity(entity: entityDescription, insertInto: viewContext)

        city.cityName = cityWeather.cityName
        city.dateAdded = Date()

        let dailyEntityModels = cityWeather.dailyModels.compactMap { dailyModel -> DailyWeatherEntryEntity? in

            guard let entityDescription = NSEntityDescription.entity(forEntityName: "DailyWeatherEntry", in: viewContext) else { return nil }

            let daily = DailyWeatherEntryEntity(entity: entityDescription, insertInto: viewContext)
            daily.apparentTemperatureHigh = dailyModel.apparentTemperatureHigh
            daily.cloudCover = dailyModel.cloudCover
            daily.icon = dailyModel.icon
            daily.moonPhase = dailyModel.moonPhase
            daily.precipProbability = dailyModel.precipProbability
            daily.precipType = dailyModel.precipType
            daily.summary = dailyModel.summary
            daily.sunriseTime = Int32(dailyModel.sunriseTime)
            daily.sunsetTime = Int32(dailyModel.sunsetTime)
            daily.temperatureMax = dailyModel.temperatureMax
            daily.temperatureMin = dailyModel.temperatureMin
            daily.time = Int32(dailyModel.time)
            daily.uvIndex = Int32(dailyModel.uvIndex)
            daily.windBearing = Int32(dailyModel.windBearing)
            daily.windSpeed = dailyModel.windSpeed

            return daily
        }

        city.dailyModels = NSSet(array: dailyEntityModels)

        let hourEntityModels = cityWeather.hourlyModels.compactMap { hourModel -> HourlyWeatherEntryEntity? in

            guard let entityDescription = NSEntityDescription.entity(forEntityName: "HourlyWeatherEntry", in: viewContext) else { return nil }

            let hourly = HourlyWeatherEntryEntity(entity: entityDescription, insertInto: viewContext)
            hourly.apparentTemperature = hourModel.apparentTemperature
            hourly.cloudCover = hourModel.cloudCover
            hourly.icon = hourModel.icon
            hourly.precipProbability = hourModel.precipProbability
            hourly.precipType = hourModel.precipType
            hourly.summary = hourModel.summary
            hourly.temperature = hourModel.temperature
            hourly.time = Int32(hourModel.time)
            hourly.windBearing = Int32(hourModel.windBearing)
            hourly.windSpeed = hourModel.windSpeed

            return hourly
        }

        city.hourlyModels = NSSet(array: hourEntityModels)

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentWeather", in: viewContext) else { return }

        let current = CurrentWeatherEntity(entity: entityDescription, insertInto: viewContext)
        current.cloudCover = cityWeather.currentModel.cloudCover
        current.icon = cityWeather.currentModel.icon
        current.precipProbability = cityWeather.currentModel.precipProbability
        current.summary = cityWeather.currentModel.summary
        current.temperature = cityWeather.currentModel.temperature
        current.time = Int32(cityWeather.currentModel.time)
        current.windSpeed = cityWeather.currentModel.windSpeed

        city.currentModel = current

        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Read
    
    public func readFromCoreData(completion: @escaping (([CityWeather]) -> Void)) {
        
        let fetchRequest = NSFetchRequest<CityWeatherEntity>(entityName: "CityWeather")
        let sort = NSSortDescriptor(key: "dateAdded", ascending: true)
        fetchRequest.sortDescriptors = [sort]

        let group = DispatchGroup()
        var weatherList = [CityWeather]()
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results {

                guard let cityName = result.cityName else { continue }
                
                group.enter()

                CLLocation.locationByCityName(address: cityName) { [weak self] decodedResult in

                    switch decodedResult {
                    case .success(let success):
                        guard let cityWeather = self?.getCityWeather(by: success, entity: result) else {
                            group.leave()
                            return
                        }
                        weatherList.append(cityWeather)
                    case .failure(let failure):
                        print(failure)
                    }
                    group.leave()
                }
            }
        } catch {
            print(error)
        }
        group.notify(queue: .main) {
            completion(weatherList)
        }
    }
    
    private func getCityWeather(by location: CLLocation, entity: CityWeatherEntity) -> CityWeather? {
        guard let dailyModelsArray = entity.dailyModels?.allObjects as? [DailyWeatherEntryEntity] else { return nil }

        let dailyEntityModels = dailyModelsArray.compactMap { dailyModel -> DailyWeatherEntry? in

            return DailyWeatherEntry(
                time: Int(dailyModel.time),
                summary: dailyModel.summary ?? "",
                icon: dailyModel.icon ?? "",
                sunriseTime: Int(dailyModel.sunriseTime),
                sunsetTime: Int(dailyModel.sunsetTime),
                moonPhase: dailyModel.moonPhase,
                precipProbability: dailyModel.precipProbability,
                precipType: dailyModel.precipType,
                windSpeed: dailyModel.windSpeed,
                windBearing: Int(dailyModel.windBearing),
                cloudCover: dailyModel.cloudCover,
                uvIndex: Int(dailyModel.uvIndex),
                temperatureMin: dailyModel.temperatureMin,
                temperatureMax: dailyModel.temperatureMax,
                apparentTemperatureHigh: dailyModel.apparentTemperatureHigh
            )
        }

        guard let hourlyModelsArray = entity.hourlyModels?.allObjects as? [HourlyWeatherEntryEntity] else { return nil }

        let hourlyEntityModels = hourlyModelsArray.compactMap { hourlyModel -> HourlyWeatherEntry? in
            return HourlyWeatherEntry(
                time: Int(hourlyModel.time),
                summary: hourlyModel.summary ?? "",
                icon: hourlyModel.icon ?? "",
                precipProbability: hourlyModel.precipProbability,
                precipType: hourlyModel.precipType,
                temperature: hourlyModel.temperature,
                apparentTemperature: hourlyModel.apparentTemperature,
                windSpeed: hourlyModel.windSpeed,
                windBearing: Int(hourlyModel.windBearing),
                cloudCover: hourlyModel.cloudCover
            )
        }

        guard let currentModel = entity.currentModel else { return nil }
        
        let currentWeather = CurrentWeather(
            time: Int(currentModel.time),
            summary: currentModel.summary ?? "",
            icon: currentModel.icon ?? "",
            precipProbability: currentModel.precipProbability,
            temperature: currentModel.temperature,
            windSpeed: currentModel.windSpeed,
            cloudCover: currentModel.cloudCover
        )

        let cityWeather = CityWeather(
            cityName: entity.cityName ?? "",
            location: location,
            dailyModels: dailyEntityModels,
            hourlyModels: hourlyEntityModels,
            currentModel: currentWeather
        )
        return cityWeather
    }
    
    // MARK: - Remove
    
    private func removeOldData(cityName: String) {
        let fetchRequest = NSFetchRequest<CityWeatherEntity>(entityName: "CityWeather")
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", cityName)

        do {
            let fetchResults = try viewContext.fetch(fetchRequest)
            fetchResults.forEach { entity in
                viewContext.delete(entity)
            }
        } catch {
            print(error)
        }
    }
    
    public func removeCity(cityName: String) {
        removeOldData(cityName: cityName)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
