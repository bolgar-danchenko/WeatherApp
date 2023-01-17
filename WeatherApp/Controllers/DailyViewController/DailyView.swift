//
//  DailyViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DailyView: UIView {
    
    var dailyModel: DailyWeatherEntry
    
    // MARK: - Subviews
    
    private lazy var summaryView: UIView = {
        let view = WeatherSummary(dailyModel: dailyModel)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunLabel: UILabel = {
        let label = UILabel()
        label.text = "Sun"
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moonLabel: UILabel = {
        let label = UILabel()
        label.text = "Moon"
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dayLength: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moonStatus: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var moonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunrise"
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunset"
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moonPhaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Moon Phase"
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunriseTime: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunsetTime: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moonPhaseValue: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorLine: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "separatorLine")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    init(dailyModel: DailyWeatherEntry) {
        self.dailyModel = dailyModel
        super.init(frame: CGRect.zero)
        configure()
        setupSubview()
        setupConstraints()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubview() {
        self.addSubview(summaryView)
        self.addSubview(sunLabel)
        self.addSubview(moonLabel)
        self.addSubview(dayLength)
        self.addSubview(moonStatus)
        self.addSubview(sunImage)
        self.addSubview(moonImage)
        self.addSubview(sunriseLabel)
        self.addSubview(sunsetLabel)
        self.addSubview(moonPhaseLabel)
        self.addSubview(sunriseTime)
        self.addSubview(sunsetTime)
        self.addSubview(moonPhaseValue)
        self.addSubview(separatorLine)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            summaryView.topAnchor.constraint(equalTo: self.topAnchor),
            summaryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            summaryView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            summaryView.heightAnchor.constraint(equalToConstant: 340),
            
            sunLabel.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 30),
            sunLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            moonLabel.centerYAnchor.constraint(equalTo: sunLabel.centerYAnchor),
            moonLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 12),
            
            sunImage.topAnchor.constraint(equalTo: sunLabel.bottomAnchor, constant: 21),
            sunImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 37),
            sunImage.widthAnchor.constraint(equalToConstant: 13.33),
            sunImage.heightAnchor.constraint(equalToConstant: 15.33),
            
            dayLength.centerYAnchor.constraint(equalTo: sunImage.centerYAnchor),
            dayLength.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -17),
            
            sunriseTime.topAnchor.constraint(equalTo: dayLength.bottomAnchor, constant: 20),
            sunriseTime.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -17),
            
            sunriseLabel.centerYAnchor.constraint(equalTo: sunriseTime.centerYAnchor),
            sunriseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 34),
            
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 17),
            sunsetLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 34),
            
            sunsetTime.centerYAnchor.constraint(equalTo: sunsetLabel.centerYAnchor),
            sunsetTime.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -17),
            
            moonImage.centerYAnchor.constraint(equalTo: sunImage.centerYAnchor),
            moonImage.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 29),
            moonImage.widthAnchor.constraint(equalToConstant: 20),
            moonImage.heightAnchor.constraint(equalToConstant: 20),
            
            moonStatus.centerYAnchor.constraint(equalTo: moonImage.centerYAnchor),
            moonStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            moonPhaseValue.topAnchor.constraint(equalTo: moonStatus.bottomAnchor, constant: 20),
            moonPhaseValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            moonPhaseLabel.centerYAnchor.constraint(equalTo: moonPhaseValue.centerYAnchor),
            moonPhaseLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 27),
            
            separatorLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separatorLine.topAnchor.constraint(equalTo: sunLabel.bottomAnchor, constant: 15),
            separatorLine.heightAnchor.constraint(equalToConstant: 100),
            separatorLine.widthAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    // MARK: - Configure
    
    private func configure() {
        sunriseTime.text = WeatherManager.shared.getTime(date: dailyModel.sunriseTime, format: TimeFormat.time.rawValue)
        sunsetTime.text = WeatherManager.shared.getTime(date: dailyModel.sunsetTime, format: TimeFormat.time.rawValue)
        
        moonPhaseValue.text = "\(Int(dailyModel.moonPhase * 100))%"
        moonStatus.text = checkMoonPhase(phase: dailyModel.moonPhase)
    
        let delta = Date(timeIntervalSince1970: Double(dailyModel.sunriseTime)).distance(to: Date(timeIntervalSince1970: Double(dailyModel.sunsetTime)))
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        
        if let dayLengthString = formatter.string(from: delta) {
            dayLength.text = dayLengthString
        }
    }
    
    func checkMoonPhase(phase: Double) -> String {
        if phase == 0 {
            return MoonPhases.newMoon.rawValue
        } else if phase == 100 {
            return MoonPhases.fullMoon.rawValue
        } else if phase == 50 {
            return MoonPhases.quarter.rawValue
        } else {
            return MoonPhases.crescent.rawValue
        }
    }
}
