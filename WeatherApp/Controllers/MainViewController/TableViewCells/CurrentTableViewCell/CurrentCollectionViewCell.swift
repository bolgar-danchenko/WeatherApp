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
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        imageView.image = UIImage(named: "rain")
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
    
    private lazy var cloudStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(cloudView)
        stackView.addArrangedSubview(cloudCoverLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(windView)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var precipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(precipView)
        stackView.addArrangedSubview(precipLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.addSubview(cloudStackView)
        contentView.addSubview(windStackView)
        contentView.addSubview(precipStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            ellipseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
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
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            dateLabel.widthAnchor.constraint(equalToConstant: 180),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),

            windStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            windStackView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 15),
            windStackView.heightAnchor.constraint(equalToConstant: 20),
            windStackView.widthAnchor.constraint(equalToConstant: 60),

            cloudStackView.centerYAnchor.constraint(equalTo: windStackView.centerYAnchor),
            cloudStackView.trailingAnchor.constraint(equalTo: windStackView.leadingAnchor, constant: -19),
            cloudStackView.heightAnchor.constraint(equalToConstant: 20),
            cloudStackView.widthAnchor.constraint(equalToConstant: 60),

            precipStackView.centerYAnchor.constraint(equalTo: windStackView.centerYAnchor),
            precipStackView.leadingAnchor.constraint(equalTo: windStackView.trailingAnchor, constant: 19),
            precipStackView.heightAnchor.constraint(equalToConstant: 20),
            precipStackView.widthAnchor.constraint(equalToConstant: 60),
        
        ])
    }
    
    // MARK: - Configure
    
    func configure(currentModel: CurrentWeather, dailyModel: DailyWeatherEntry) {
        
        let currentCelsiusTemp = WeatherManager.shared.getCelsiusTemp(from: currentModel.temperature)
        currentTempLabel.text = "\(currentCelsiusTemp)°"
        
        let minCelsiusTemp = WeatherManager.shared.getCelsiusTemp(from: dailyModel.temperatureMin)
        let maxCelsiusTemp = WeatherManager.shared.getCelsiusTemp(from: dailyModel.temperatureMax)
        minMaxTempLabel.text = "\(minCelsiusTemp)°/\(maxCelsiusTemp)°"
        
        summaryLabel.text = currentModel.summary
        
        let cloudPercentage = Int(currentModel.cloudCover*100)
        cloudCoverLabel.text = "\(cloudPercentage)%"
        
        windSpeedLabel.text = "\(currentModel.windSpeed)"
        
        let precipPercentage = Int(currentModel.precipProbability*100)
        precipLabel.text = "\(precipPercentage)%"

        dateLabel.text = getDateTime(Date(timeIntervalSince1970: Double(currentModel.time)))
        
        sunriseTimeLabel.text = getTime(Date(timeIntervalSince1970: Double(dailyModel.sunriseTime)))
        
        sunsetTimeLabel.text = getTime(Date(timeIntervalSince1970: Double(dailyModel.sunsetTime)))
    }
    
    func getDateTime(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a" // Nov 26, 3:12 PM
        
        return formatter.string(from: inputDate)
    }
    
    func getTime(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // 12:00
        
        return formatter.string(from: inputDate)
    }
}
