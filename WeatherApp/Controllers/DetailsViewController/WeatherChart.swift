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
    
    func getTime(_ dateInt: Int) -> String {
        
        let date = Date(timeIntervalSince1970: Double(dateInt))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // 12:00
        return formatter.string(from: date)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            Chart(hourlyModels) { hour in
                LineMark(
                    x: .value("Time", getTime(hour.time)),
                    y: .value("Temperature", WeatherManager.shared.getCelsiusTemp(from: hour.temperature))
                )
                .foregroundStyle(Color(uiColor: Styles.darkBlueColor))
                .annotation(position: .top) {
                    Text("\(WeatherManager.shared.getCelsiusTemp(from: hour.temperature))°")
                        .font(.custom("RubikRoman-Regular", size: 14))
                }
                
                PointMark(x: .value("Time", getTime(hour.time)),
                          y: .value("Temperature", WeatherManager.shared.getCelsiusTemp(from: hour.temperature)))
                .foregroundStyle(.white)
                .symbolSize(40)
                
//                AreaMark(x: .value("Time", "\(hour.time)"),
//                         yStart: .value("Temperature", hour.temperature),
//                         yEnd: .value("minValue", 0))
//                .interpolationMethod(.cardinal)
            }
            .frame(width: 1300)
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
