//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 10.01.2023.
//

import UIKit

class WeatherSummary: UIView {

    var dailyModel: DailyWeatherEntry
    
    // MARK: - Properties
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular30Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.text = "Feels Like"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.text = "Wind"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var uvIndexLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.text = "UV Index"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.text = "Precipitation"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.text = "Cloud Cover"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var uvIndexValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "temp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueWind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var uvIndexImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var precipImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud-rain")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cloudImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    init(dailyModel: DailyWeatherEntry) {
        self.dailyModel = dailyModel
        super.init(frame: CGRect.zero)
        configure()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupView() {
        self.backgroundColor = Styles.solitudeColor
        
        self.addSubview(tempLabel)
        self.addSubview(weatherImage)
        self.addSubview(summaryLabel)
        self.addSubview(feelsLikeLabel)
        self.addSubview(windLabel)
        self.addSubview(uvIndexLabel)
        self.addSubview(precipLabel)
        self.addSubview(cloudLabel)
        self.addSubview(feelsLikeValue)
        self.addSubview(windValue)
        self.addSubview(uvIndexValue)
        self.addSubview(precipValue)
        self.addSubview(cloudValue)
        self.addSubview(feelsLikeImage)
        self.addSubview(windImage)
        self.addSubview(uvIndexImage)
        self.addSubview(precipImage)
        self.addSubview(cloudImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 170),
        
            weatherImage.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 30),
            
            summaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            summaryLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 15),
            summaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            summaryLabel.heightAnchor.constraint(equalToConstant: 45),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            
            windLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 27),
            windLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            
            uvIndexLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 27),
            uvIndexLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            
            precipLabel.topAnchor.constraint(equalTo: uvIndexLabel.bottomAnchor, constant: 27),
            precipLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            
            cloudLabel.topAnchor.constraint(equalTo: precipLabel.bottomAnchor, constant: 27),
            cloudLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
            
            feelsLikeImage.centerYAnchor.constraint(equalTo: feelsLikeLabel.centerYAnchor),
            feelsLikeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            feelsLikeImage.widthAnchor.constraint(equalToConstant: 20),
            feelsLikeImage.heightAnchor.constraint(equalToConstant: 23),
            
            windImage.centerXAnchor.constraint(equalTo: feelsLikeImage.centerXAnchor),
            windImage.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windImage.widthAnchor.constraint(equalToConstant: 24),
            windImage.heightAnchor.constraint(equalToConstant: 14),
            
            uvIndexImage.centerXAnchor.constraint(equalTo: feelsLikeImage.centerXAnchor),
            uvIndexImage.centerYAnchor.constraint(equalTo: uvIndexLabel.centerYAnchor),
            uvIndexImage.widthAnchor.constraint(equalToConstant: 16),
            uvIndexImage.heightAnchor.constraint(equalToConstant: 18),
            
            precipImage.centerXAnchor.constraint(equalTo: feelsLikeImage.centerXAnchor),
            precipImage.centerYAnchor.constraint(equalTo: precipLabel.centerYAnchor),
            precipImage.widthAnchor.constraint(equalToConstant: 25),
            precipImage.heightAnchor.constraint(equalToConstant: 27.21),
            
            cloudImage.centerXAnchor.constraint(equalTo: feelsLikeImage.centerXAnchor),
            cloudImage.centerYAnchor.constraint(equalTo: cloudLabel.centerYAnchor),
            cloudImage.widthAnchor.constraint(equalToConstant: 20),
            cloudImage.heightAnchor.constraint(equalToConstant: 18),
            
            feelsLikeValue.centerYAnchor.constraint(equalTo: feelsLikeLabel.centerYAnchor),
            feelsLikeValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            windValue.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            uvIndexValue.centerYAnchor.constraint(equalTo: uvIndexLabel.centerYAnchor),
            uvIndexValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            precipValue.centerYAnchor.constraint(equalTo: precipLabel.centerYAnchor),
            precipValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            cloudValue.centerYAnchor.constraint(equalTo: cloudLabel.centerYAnchor),
            cloudValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - Configure
    
    private func configure() {
        
        self.tempLabel.text = "\(WeatherManager.shared.getCelsiusTemp(from: dailyModel.temperatureMax))°"
        self.summaryLabel.text = dailyModel.summary
        
        let icon = dailyModel.icon.lowercased()
        if icon.contains("clear") {
            self.weatherImage.image = UIImage(named: "sun")
        } else if icon.contains("rain") {
            self.weatherImage.image = UIImage(named: "cloud-rain")
        } else {
            self.weatherImage.image = UIImage(named: "cloud")
        }
        
        self.feelsLikeValue.text = "\(WeatherManager.shared.getCelsiusTemp(from: dailyModel.apparentTemperatureHigh))°"
        self.windValue.text = "\(Int(dailyModel.windSpeed)) m/s"
        self.uvIndexValue.text = "\(dailyModel.uvIndex)"
        self.precipValue.text = "\(Int(dailyModel.precipProbability * 100))%"
        self.cloudValue.text = "\(Int(dailyModel.cloudCover * 100))%"
    }
}
