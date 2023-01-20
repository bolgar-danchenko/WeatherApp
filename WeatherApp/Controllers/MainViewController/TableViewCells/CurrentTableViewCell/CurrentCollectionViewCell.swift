//
//  CurrentCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class CurrentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentCollectionViewCell"
    
    // MARK: - Subviews
    
    private lazy var minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular16Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikMedium36Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular16Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudCoverLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.applyStyle(font: Styles.rubikMedium14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.applyStyle(font: Styles.rubikMedium14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.yellowColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ellipseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cloudView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloudCover")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var precipView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "precip")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sunriseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunrise")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Styles.yellowColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sunsetView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Styles.yellowColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Styles.darkBlueColor
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupView() {
        contentView.addSubview(minMaxTempLabel)
        contentView.addSubview(currentTempLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(sunriseTimeLabel)
        contentView.addSubview(sunsetTimeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(ellipseView)
        contentView.addSubview(sunriseView)
        contentView.addSubview(sunsetView)
        contentView.addSubview(cloudView)
        contentView.addSubview(cloudCoverLabel)
        contentView.addSubview(windView)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(precipView)
        contentView.addSubview(precipLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            ellipseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            ellipseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            ellipseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -31),
            ellipseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -73),
            
            minMaxTempLabel.topAnchor.constraint(equalTo: ellipseView.topAnchor, constant: 16),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            minMaxTempLabel.widthAnchor.constraint(equalToConstant: 80),
            minMaxTempLabel.heightAnchor.constraint(equalToConstant: 20),

            currentTempLabel.topAnchor.constraint(equalTo: minMaxTempLabel.bottomAnchor, constant: 5),
            currentTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentTempLabel.widthAnchor.constraint(equalToConstant: 90),
            currentTempLabel.heightAnchor.constraint(equalToConstant: 40),

            summaryLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5),
            summaryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryLabel.widthAnchor.constraint(equalToConstant: 250),
            summaryLabel.heightAnchor.constraint(equalToConstant: 20),

            sunriseTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            sunriseTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
            sunriseTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            sunriseTimeLabel.widthAnchor.constraint(equalToConstant: 45),

            sunsetTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            sunsetTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
            sunsetTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            sunsetTimeLabel.widthAnchor.constraint(equalToConstant: 45),

            sunriseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            sunriseView.bottomAnchor.constraint(equalTo: sunriseTimeLabel.topAnchor, constant: -5),
            sunriseView.heightAnchor.constraint(equalToConstant: 17),
            sunriseView.widthAnchor.constraint(equalToConstant: 17),

            sunsetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            sunsetView.bottomAnchor.constraint(equalTo: sunsetTimeLabel.topAnchor, constant: -5),
            sunsetView.heightAnchor.constraint(equalToConstant: 17),
            sunsetView.widthAnchor.constraint(equalToConstant: 17),

            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            dateLabel.widthAnchor.constraint(equalToConstant: 180),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            windView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 15),
            windView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30),
            windView.heightAnchor.constraint(equalToConstant: 16),
            windView.widthAnchor.constraint(equalToConstant: 25),
            
            windSpeedLabel.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            windSpeedLabel.leadingAnchor.constraint(equalTo: windView.trailingAnchor, constant: 5),
            
            precipView.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            precipView.widthAnchor.constraint(equalToConstant: 13),
            precipView.heightAnchor.constraint(equalToConstant: 15),
            precipView.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor, constant: 25),
            
            precipLabel.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            precipLabel.leadingAnchor.constraint(equalTo: precipView.trailingAnchor, constant: 5),
            
            cloudView.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            cloudView.widthAnchor.constraint(equalToConstant: 21),
            cloudView.heightAnchor.constraint(equalToConstant: 18),
            cloudView.trailingAnchor.constraint(equalTo: cloudCoverLabel.leadingAnchor, constant: -5),
            
            cloudCoverLabel.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            cloudCoverLabel.trailingAnchor.constraint(equalTo: windView.leadingAnchor, constant: -20),
        
        ])
    }
    
    // MARK: - Configure
    
    func configure(currentModel: CurrentWeather, dailyModel: DailyWeatherEntry) {
        
        let currentCelsiusTemp = WeatherManager.shared.getTemp(from: currentModel.temperature)
        currentTempLabel.text = "\(currentCelsiusTemp)°"
        
        let minCelsiusTemp = WeatherManager.shared.getTemp(from: dailyModel.temperatureMin)
        let maxCelsiusTemp = WeatherManager.shared.getTemp(from: dailyModel.temperatureMax)
        minMaxTempLabel.text = "\(minCelsiusTemp)°/\(maxCelsiusTemp)°"
        
        summaryLabel.text = currentModel.summary
        
        let cloudPercentage = Int(currentModel.cloudCover*100)
        cloudCoverLabel.text = "\(Int(cloudPercentage))%"
        
        windSpeedLabel.text = WeatherManager.shared.getSpeed(from: currentModel.windSpeed)
        
        let precipPercentage = Int(currentModel.precipProbability*100)
        precipLabel.text = "\(precipPercentage)%"
        
        if UserDefaults.standard.value(forKey: "time-units") as? String == "24h" {
            dateLabel.text = WeatherManager.shared.getTime(date: currentModel.time, format: TimeFormat.dateAndTime24.rawValue)
            sunriseTimeLabel.text = WeatherManager.shared.getTime(date: dailyModel.sunriseTime, format: TimeFormat.time24.rawValue)
            sunsetTimeLabel.text = WeatherManager.shared.getTime(date: dailyModel.sunsetTime, format: TimeFormat.time24.rawValue)
        } else {
            dateLabel.text = WeatherManager.shared.getTime(date: currentModel.time, format: TimeFormat.dateAndTime12.rawValue)
            sunriseTimeLabel.text = WeatherManager.shared.getTime(date: dailyModel.sunriseTime, format: TimeFormat.time12.rawValue)
            sunsetTimeLabel.text = WeatherManager.shared.getTime(date: dailyModel.sunsetTime, format: TimeFormat.time12.rawValue)
        }
    }
}
