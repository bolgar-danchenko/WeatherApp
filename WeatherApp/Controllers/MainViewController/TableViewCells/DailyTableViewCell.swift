//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    static let identifier = "DailyTableViewCell"
    
    // MARK: - Subviews
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.dateGrayColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.summaryDarkGrayColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosureIndicator")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var precipProbabilityLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular12Font, color: Styles.darkBlueColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var uiView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.solitudeColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        contentView.addSubview(uiView)
        uiView.addSubview(dateLabel)
        uiView.addSubview(summaryLabel)
        uiView.addSubview(tempLabel)
        uiView.addSubview(weatherImage)
        uiView.addSubview(disclosureIndicator)
        uiView.addSubview(precipProbabilityLabel)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            uiView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            uiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            uiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            uiView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            dateLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 19),
            dateLabel.widthAnchor.constraint(equalToConstant: 60),
            
            weatherImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4.68),
            weatherImage.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 17),
            weatherImage.widthAnchor.constraint(equalToConstant: 17),
            
            precipProbabilityLabel.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            precipProbabilityLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 5),
            precipProbabilityLabel.heightAnchor.constraint(equalToConstant: 23),
            precipProbabilityLabel.widthAnchor.constraint(equalToConstant: 20),
            
            summaryLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            summaryLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 66),
            summaryLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -72),
            summaryLabel.heightAnchor.constraint(equalToConstant: 19),
            
            tempLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: disclosureIndicator.leadingAnchor, constant: -10),
            tempLabel.heightAnchor.constraint(equalToConstant: 21.83),
            tempLabel.widthAnchor.constraint(equalToConstant: 70),
            
            disclosureIndicator.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            disclosureIndicator.widthAnchor.constraint(equalToConstant: 6),
            disclosureIndicator.heightAnchor.constraint(equalToConstant: 9.49)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with model: DailyWeatherEntry) {
        self.dateLabel.text = getDate(Date(timeIntervalSince1970: Double(model.time)))
        self.precipProbabilityLabel.text = "\(Int(model.precipProbability))%"
        
        let celsiusTempMin = WeatherManager.shared.getCelsiusTemp(from: model.temperatureMin)
        let celsiusTempMax = WeatherManager.shared.getCelsiusTemp(from: model.temperatureMax)
        
        self.tempLabel.text = "\(celsiusTempMin)° - \(celsiusTempMax)°"
        
        let summary = model.summary.lowercased()
        if summary.contains("cloudy") {
            self.summaryLabel.text = "Party Cloudy"
        } else if summary.contains("clear") {
            self.summaryLabel.text = "Clear"
        } else if summary.contains("rain") {
            self.summaryLabel.text = "Rain"
        } else if summary.contains("thunder") {
            self.summaryLabel.text = "Thunderstorm"
        } else if summary.contains("overcast") {
            self.summaryLabel.text = "Overcast"
        } else if summary.contains("possible drizzle") {
            self.summaryLabel.text = "Possible Drizzle"
        } else {
            self.summaryLabel.text = model.summary
        }
        
        let icon = model.icon.lowercased()
        if icon.contains("clear") {
            self.weatherImage.image = UIImage(named: "sun")
        } else if icon.contains("rain") {
            self.weatherImage.image = UIImage(named: "cloud-rain")
        } else {
            self.weatherImage.image = UIImage(named: "cloud")
        }
    }
    
    private func getDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d/MM" // 25/11
        
        return formatter.string(from: inputDate)
    }
}