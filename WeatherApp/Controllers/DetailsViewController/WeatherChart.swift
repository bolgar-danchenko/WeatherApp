//
//  WeatherChart.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 09.01.2023.
//

import Foundation
import SwiftUI
import Charts

struct WeatherChart: View {
    
    let hourlyModels: [HourlyWeatherEntry]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                // MARK: - Temperature Chart
                Chart {
                    ForEach(hourlyModels) { hour in
                        LineMark(
                            x: .value(
                                "Time",
                                WeatherManager.shared.getTime(
                                    date: hour.time,
                                    format: (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? TimeFormat.time24.rawValue : TimeFormat.time12.rawValue
                                )
                            ),
                            y: .value("Temperature", WeatherManager.shared.getTemp(from: hour.temperature))
                        )
                        .lineStyle(.init(lineWidth: 0.7))
                        .foregroundStyle(Color(uiColor: Styles.darkBlueColor))
                        
                        PointMark(
                            x: .value(
                                "Time",
                                WeatherManager.shared.getTime(
                                    date: hour.time,
                                    format: (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? TimeFormat.time24.rawValue : TimeFormat.time12.rawValue
                                )
                            ),
                            y: .value("Temperature", WeatherManager.shared.getTemp(from: hour.temperature))
                        )
                        .foregroundStyle(.white)
                        .symbolSize(40)
                        .annotation(position: .top, alignment: .center) {
                            Text("\(WeatherManager.shared.getTemp(from: hour.temperature))°")
                                .font(.custom("RubikRoman-Regular", size: 14))
                                .padding(.bottom, 5)
                        }
                        
                        AreaMark(
                            x: .value(
                                "Time",
                                WeatherManager.shared.getTime(
                                    date: hour.time,
                                    format: (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? TimeFormat.time24.rawValue : TimeFormat.time12.rawValue
                                )
                            ),
                            yStart: .value("Temperature", WeatherManager.shared.getTemp(from: hour.temperature) >= 0 ? WeatherManager.shared.getTemp(from: hour.temperature) - 1 : WeatherManager.shared.getTemp(from: hour.temperature) + 1),
                            yEnd: .value("minValue", 0)
                        )
                        .foregroundStyle(WeatherManager.shared.getTemp(from: hour.temperature) >= 0 ? Gradient(colors: [
                            Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0),
                        ]) : Gradient(colors: [
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                            Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3),
                        ]))
                    }
                }
                .frame(width: 1500, height: 60)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .padding(.top, 20)
                .padding(.bottom, 8)
                .background(Color(uiColor: Styles.solitudeColor))
                
                // MARK: - Precipitation Chart
                Chart {
                    ForEach(hourlyModels) { hour in
                        LineMark(
                            x: .value(
                                "Time",
                                WeatherManager.shared.getTime(
                                    date: hour.time,
                                    format: (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? TimeFormat.time24.rawValue : TimeFormat.time12.rawValue
                                )
                            ),
                            y: .value("Precipitation", Int(hour.precipProbability * 100))
                        )
                        .lineStyle(.init(lineWidth: 1.0))
                        .foregroundStyle(Color(uiColor: Styles.darkBlueColor))
                        
                        PointMark(
                            x: .value(
                                "Time",
                                WeatherManager.shared.getTime(
                                    date: hour.time,
                                    format: (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? TimeFormat.time24.rawValue : TimeFormat.time12.rawValue
                                )
                            ),
                            y: .value("Precipitation", Int(hour.precipProbability * 100))
                        )
                        .foregroundStyle(Color(uiColor: Styles.darkBlueColor))
                        .symbol() {
                            Rectangle()
                                .fill(Color(uiColor: Styles.darkBlueColor))
                                .frame(width: 4, height: 8)
                        }
                        .symbolSize(40)
                        .annotation(position: .top, alignment: .center) {
                            VStack {
                                
                                Image("cloud-rain")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Text("\(Int(hour.precipProbability * 100))%")
                                    .font(.custom("RubikRoman-Regular", size: 12))
                                    .padding(.bottom, 5)
                            }
                        }
                        
                    }
                   
                }
                .frame(width: 1500, height: 70)
                .chartXAxis {
                    AxisMarks { mark in
                        AxisValueLabel()
                            .font(.custom("RubikRoman-Regular", size: 14))
                            .foregroundStyle(.black)
                    }
                }
                .chartYAxis(.hidden)
                .padding(.top, 20)
                .padding(.bottom, 8)
                .background(Color(uiColor: Styles.solitudeColor))
            }
        }
    }
}
