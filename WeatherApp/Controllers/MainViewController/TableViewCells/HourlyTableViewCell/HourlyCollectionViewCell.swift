//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            timeLabel.widthAnchor.constraint(equalToConstant: 40),
            
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 3),
            weatherImage.heightAnchor.constraint(equalToConstant: 20),
            weatherImage.widthAnchor.constraint(equalToConstant: 20),
            
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            tempLabel.heightAnchor.constraint(equalToConstant: 18),
            tempLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with model: HourlyWeatherEntry) {
        
        let celsiusTemp = WeatherManager.shared.getCelsiusTemp(from: model.temperature)
        self.tempLabel.text = "\(celsiusTemp)°"
        
        self.timeLabel.text = getTime(Date(timeIntervalSince1970: Double(model.time)))
        
        let icon = model.icon.lowercased()
        if icon.contains("clear") {
            self.weatherImage.image = UIImage(named: "sun")
        } else if icon.contains("rain") {
            self.weatherImage.image = UIImage(named: "cloud-rain")
        } else {
            self.weatherImage.image = UIImage(named: "cloud")
        }
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
