//
//  ChartView.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 12.01.2023.
//

import UIKit
import SwiftUI

class ChartView: UIView {
    
    let hourlyModels: [HourlyWeatherEntry]
    
    init(hourlyModels: [HourlyWeatherEntry]) {
        self.hourlyModels = hourlyModels
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let controller = UIHostingController(rootView: WeatherChart(hourlyModels: hourlyModels))
        guard let chartView = controller.view else { return }
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(chartView)
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: self.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
