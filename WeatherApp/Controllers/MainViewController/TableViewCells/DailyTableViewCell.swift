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
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.summaryDarkGrayColor)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        label.textAlignment = .right
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
            dateLabel.trailingAnchor.constraint(equalTo: precipProbabilityLabel.trailingAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4.68),
            weatherImage.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 17),
            weatherImage.widthAnchor.constraint(equalToConstant: 17),
            
            precipProbabilityLabel.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            precipProbabilityLabel.trailingAnchor.constraint(equalTo: summaryLabel.leadingAnchor, constant: -7),
            precipProbabilityLabel.heightAnchor.constraint(equalToConstant: 23),
            precipProbabilityLabel.widthAnchor.constraint(equalToConstant: 30),
            
            summaryLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            summaryLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 66),
            summaryLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -5),
            summaryLabel.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            
            tempLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: disclosureIndicator.leadingAnchor, constant: -10),
            tempLabel.heightAnchor.constraint(equalToConstant: 21.83),
            tempLabel.widthAnchor.constraint(equalToConstant: 80),
            
            disclosureIndicator.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            disclosureIndicator.widthAnchor.constraint(equalToConstant: 6),
            disclosureIndicator.heightAnchor.constraint(equalToConstant: 9.49)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with model: DailyWeatherEntry) {
        dateLabel.text = WeatherManager.shared.getTime(date: model.time, format: TimeFormat.date.rawValue)
        precipProbabilityLabel.text = "\(Int(model.precipProbability*100))%"
        
        let celsiusTempMin = WeatherManager.shared.getCelsiusTemp(from: model.temperatureMin)
        let celsiusTempMax = WeatherManager.shared.getCelsiusTemp(from: model.temperatureMax)
        
        tempLabel.text = "\(celsiusTempMin)°/\(celsiusTempMax)°"
        summaryLabel.text = model.summary
        
        let icon = model.icon.lowercased()
        if icon.contains("clear") {
            weatherImage.image = UIImage(named: "sun")
        } else if icon.contains("rain") {
            weatherImage.image = UIImage(named: "cloud-rain")
        } else {
            weatherImage.image = UIImage(named: "cloud")
        }
    }
}
