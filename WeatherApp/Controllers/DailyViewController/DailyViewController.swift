//
//  DailyViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DailyViewController: UIViewController {
    
    var dailyModel: DailyWeatherEntry
    
    // MARK: - Subviews
    
    private lazy var backArrow: UIButton = {
        let backArrow = UIButton()
        backArrow.setImage(UIImage(named: "backArrow"), for: .normal)
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return backArrow
    }()
    
    private lazy var backLabel: UILabel = {
        let backLabel = UILabel()
        backLabel.text = "Daily Weather"
        backLabel.font = Styles.rubikRegular16Font
        backLabel.textColor = Styles.settingsGrayColor
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        return backLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Location"
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dailyWeatherView: UIView = {
        let view = DailyWeatherView(dailyModel: dailyModel)
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
    
    private lazy var dottedLine: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dottedLine")?.withTintColor(Styles.darkBlueColor, renderingMode: .alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    init(dailyModel: DailyWeatherEntry) {
        self.dailyModel = dailyModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        setLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupSubview()
        setupConstraints()
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setupSubview() {
        view.addSubview(backArrow)
        view.addSubview(backLabel)
        view.addSubview(locationLabel)
        view.addSubview(dailyWeatherView)
        view.addSubview(sunLabel)
        view.addSubview(moonLabel)
        view.addSubview(dayLength)
        view.addSubview(moonStatus)
        view.addSubview(sunImage)
        view.addSubview(moonImage)
        view.addSubview(sunriseLabel)
        view.addSubview(sunsetLabel)
        view.addSubview(moonPhaseLabel)
        view.addSubview(sunriseTime)
        view.addSubview(sunsetTime)
        view.addSubview(moonPhaseValue)
        view.addSubview(separatorLine)
        view.addSubview(dottedLine)
    }
    
    private func setLocation() {
        guard let currentLocation = LocationManager.shared.currentLocation else { return }
        
        DispatchQueue.main.async {
            LocationManager.shared.resolveLocationName(with: currentLocation) { locationName in
                guard let locationName = locationName else { return }
                self.locationLabel.text = locationName
            }
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            backLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            backLabel.heightAnchor.constraint(equalToConstant: 20),
            backLabel.widthAnchor.constraint(equalToConstant: 250),
            
            backArrow.centerYAnchor.constraint(equalTo: backLabel.centerYAnchor),
            backArrow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            backArrow.heightAnchor.constraint(equalToConstant: 9),
            backArrow.widthAnchor.constraint(equalToConstant: 15),
            
            locationLabel.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: 15),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationLabel.heightAnchor.constraint(equalToConstant: 22),
            
            dailyWeatherView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            dailyWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyWeatherView.heightAnchor.constraint(equalToConstant: 340),
            
            sunLabel.topAnchor.constraint(equalTo: dailyWeatherView.bottomAnchor, constant: 30),
            sunLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            moonLabel.centerYAnchor.constraint(equalTo: sunLabel.centerYAnchor),
            moonLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12),
            
            sunImage.topAnchor.constraint(equalTo: sunLabel.bottomAnchor, constant: 21),
            sunImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            sunImage.widthAnchor.constraint(equalToConstant: 13.33),
            sunImage.heightAnchor.constraint(equalToConstant: 15.33),
            
            dayLength.centerYAnchor.constraint(equalTo: sunImage.centerYAnchor),
            dayLength.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -17),
            
            sunriseTime.topAnchor.constraint(equalTo: dayLength.bottomAnchor, constant: 20),
            sunriseTime.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -17),
            
            sunriseLabel.centerYAnchor.constraint(equalTo: sunriseTime.centerYAnchor),
            sunriseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 17),
            sunsetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            
            sunsetTime.centerYAnchor.constraint(equalTo: sunsetLabel.centerYAnchor),
            sunsetTime.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -17),
            
            moonImage.centerYAnchor.constraint(equalTo: sunImage.centerYAnchor),
            moonImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 29),
            moonImage.widthAnchor.constraint(equalToConstant: 20),
            moonImage.heightAnchor.constraint(equalToConstant: 20),
            
            moonStatus.centerYAnchor.constraint(equalTo: moonImage.centerYAnchor),
            moonStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            moonPhaseValue.topAnchor.constraint(equalTo: moonStatus.bottomAnchor, constant: 20),
            moonPhaseValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            moonPhaseLabel.centerYAnchor.constraint(equalTo: moonPhaseValue.centerYAnchor),
            moonPhaseLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 27),
            
            separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLine.topAnchor.constraint(equalTo: sunLabel.bottomAnchor, constant: 15),
            separatorLine.heightAnchor.constraint(equalToConstant: 100),
            separatorLine.widthAnchor.constraint(equalToConstant: 1),
            
            dottedLine.topAnchor.constraint(equalTo: dayLength.bottomAnchor, constant: 12),
            dottedLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dottedLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dottedLine.heightAnchor.constraint(equalToConstant: 2),
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
