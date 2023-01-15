//
//  DetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 09.01.2023.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    static let identifier = "DetailsTableViewCell"
    
    var hidesBottomSeparator = false
    
    // MARK: - Subviews
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsValueLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var precipValueLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudValueLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: Styles.dateGrayColor)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var summaryImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "crescent")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueWind")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var precipImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rain")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bottomSeparator = subviews.first { $0.frame.minY >= bounds.maxY - 1 && $0.frame.height <= 1 }
        bottomSeparator?.isHidden = hidesBottomSeparator
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = Styles.solitudeColor
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(precipLabel)
        contentView.addSubview(cloudLabel)
        contentView.addSubview(feelsValueLabel)
        contentView.addSubview(windValueLabel)
        contentView.addSubview(precipValueLabel)
        contentView.addSubview(cloudValueLabel)
        contentView.addSubview(summaryImage)
        contentView.addSubview(windImage)
        contentView.addSubview(precipImage)
        contentView.addSubview(cloudImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.widthAnchor.constraint(equalToConstant: 47),
            timeLabel.heightAnchor.constraint(equalToConstant: 19),
            
            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tempLabel.heightAnchor.constraint(equalToConstant: 23),
            
            summaryImage.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            summaryImage.trailingAnchor.constraint(equalTo: summaryLabel.leadingAnchor, constant: -7),
            summaryImage.widthAnchor.constraint(equalToConstant: 12),
            summaryImage.heightAnchor.constraint(equalToConstant: 12),
            
            summaryLabel.centerYAnchor.constraint(equalTo: summaryImage.centerYAnchor),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            summaryLabel.heightAnchor.constraint(equalToConstant: 19),
            
            feelsValueLabel.centerYAnchor.constraint(equalTo: summaryLabel.centerYAnchor),
            feelsValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            feelsValueLabel.heightAnchor.constraint(equalToConstant: 19),
            
            windImage.centerXAnchor.constraint(equalTo: summaryImage.centerXAnchor),
            windImage.topAnchor.constraint(equalTo: summaryImage.bottomAnchor, constant: 16),
            windImage.heightAnchor.constraint(equalToConstant: 10),
            windImage.widthAnchor.constraint(equalToConstant: 15),
            
            windLabel.centerYAnchor.constraint(equalTo: windImage.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            windLabel.heightAnchor.constraint(equalToConstant: 19),
            
            windValueLabel.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            windValueLabel.heightAnchor.constraint(equalToConstant: 19),
            
            precipImage.centerXAnchor.constraint(equalTo: summaryImage.centerXAnchor),
            precipImage.topAnchor.constraint(equalTo: windImage.bottomAnchor, constant: 16),
            precipImage.heightAnchor.constraint(equalToConstant: 13),
            precipImage.widthAnchor.constraint(equalToConstant: 11),
            
            precipLabel.centerYAnchor.constraint(equalTo: precipImage.centerYAnchor),
            precipLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            precipLabel.heightAnchor.constraint(equalToConstant: 19),
            
            precipValueLabel.centerYAnchor.constraint(equalTo: precipLabel.centerYAnchor),
            precipValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            precipValueLabel.heightAnchor.constraint(equalToConstant: 19),
            
            cloudImage.centerXAnchor.constraint(equalTo: summaryImage.centerXAnchor),
            cloudImage.topAnchor.constraint(equalTo: precipImage.bottomAnchor, constant: 16),
            cloudImage.heightAnchor.constraint(equalToConstant: 10),
            cloudImage.widthAnchor.constraint(equalToConstant: 14),
            
            cloudLabel.centerYAnchor.constraint(equalTo: cloudImage.centerYAnchor),
            cloudLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            cloudLabel.heightAnchor.constraint(equalToConstant: 19),
            
            cloudValueLabel.centerYAnchor.constraint(equalTo: cloudLabel.centerYAnchor),
            cloudValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cloudValueLabel.heightAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    // MARK: - Configure
    
    func configure(with model: HourlyWeatherEntry) {
        
        self.dateLabel.text = WeatherManager.shared.getTime(date: model.time, format: TimeFormat.dayAndDate.rawValue)
        self.timeLabel.text = WeatherManager.shared.getTime(date: model.time, format: TimeFormat.time.rawValue)
        self.tempLabel.text = "\(WeatherManager.shared.getCelsiusTemp(from: model.temperature))°"
        self.feelsValueLabel.text = "Feels like \(WeatherManager.shared.getCelsiusTemp(from: model.apparentTemperature))°"
        
        self.summaryLabel.text = model.summary
        self.windLabel.text = "Wind"
        self.windValueLabel.text = "\(Int(model.windSpeed)) m/s"
        self.precipLabel.text = "Precipitation"
        self.precipValueLabel.text = "\(Int(model.precipProbability * 100))%"
        self.cloudLabel.text = "Cloud Cover"
        self.cloudValueLabel.text = "\(Int(model.cloudCover * 100))%"
    }
}
