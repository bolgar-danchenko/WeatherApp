//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.solitudeColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.settingsGrayColor)
        label.text = "Temperature"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fahrenheitLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "F°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var celciusLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "C°"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.settingsGrayColor)
        label.text = "Wind Speed"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var kmLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "km"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var miLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "mi"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeFormatLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.settingsGrayColor)
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var h24Label: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "24h"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var h12Label: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "12h"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var notificationsLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: Styles.settingsGrayColor)
        label.text = "Notifications"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var onLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "On"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var offLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular16Font, color: .black)
        label.text = "Off"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingsButton = CustomButton(action: didTapSettingsButton, color: Styles.orangeButtonColor, title: "Confirm", titleColor: Styles.solitudeColor, font: Styles.rubikRegular16Font)
    
    private lazy var tempSwitch = CustomSwitch(action: didTapTempSwitch)
    private lazy var timeFormatSwitch = CustomSwitch(action: didTapTimeSwitch)
    private lazy var windSpeedSwitch = CustomSwitch(action: didTapWindSwitch)
    private lazy var notificationsSwitch = CustomSwitch(action: didTapNotificationsSwitch)
    
    private lazy var cloudImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud1")
        imageView.alpha = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cloudImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cloudImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Styles.darkBlueColor
        
        tempSwitch.setup()
        windSpeedSwitch.setup()
        timeFormatSwitch.setup()
        notificationsSwitch.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        setupSubview()
        setupConstraints()
        setupSwitches()
    }
    
    private func setupSubview() {
        view.addSubview(containerView)
        containerView.addSubview(settingsLabel)
        containerView.addSubview(tempLabel)
        containerView.addSubview(windSpeedLabel)
        containerView.addSubview(timeFormatLabel)
        containerView.addSubview(notificationsLabel)
        containerView.addSubview(settingsButton)
        settingsButton.setup()
        containerView.addSubview(tempSwitch)
        containerView.addSubview(windSpeedSwitch)
        containerView.addSubview(timeFormatSwitch)
        containerView.addSubview(notificationsSwitch)
        containerView.addSubview(fahrenheitLabel)
        containerView.addSubview(celciusLabel)
        containerView.addSubview(miLabel)
        containerView.addSubview(kmLabel)
        containerView.addSubview(h12Label)
        containerView.addSubview(h24Label)
        containerView.addSubview(offLabel)
        containerView.addSubview(onLabel)
        view.addSubview(cloudImage1)
        view.addSubview(cloudImage2)
        view.addSubview(cloudImage3)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            containerView.heightAnchor.constraint(equalToConstant: 330),
            containerView.widthAnchor.constraint(equalToConstant: 320),
            containerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            settingsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 27),
            settingsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            tempLabel.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            windSpeedLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
            windSpeedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            timeFormatLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 30),
            timeFormatLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            notificationsLabel.topAnchor.constraint(equalTo: timeFormatLabel.bottomAnchor, constant: 30),
            notificationsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            settingsButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 250),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            celciusLabel.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            celciusLabel.centerXAnchor.constraint(equalTo: h24Label.centerXAnchor),

            tempSwitch.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            tempSwitch.centerXAnchor.constraint(equalTo: timeFormatSwitch.centerXAnchor),

            fahrenheitLabel.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            fahrenheitLabel.centerXAnchor.constraint(equalTo: h12Label.centerXAnchor),

            kmLabel.centerYAnchor.constraint(equalTo: windSpeedLabel.centerYAnchor),
            kmLabel.centerXAnchor.constraint(equalTo: h24Label.centerXAnchor),

            windSpeedSwitch.centerYAnchor.constraint(equalTo: windSpeedLabel.centerYAnchor),
            windSpeedSwitch.centerXAnchor.constraint(equalTo: timeFormatSwitch.centerXAnchor),

            miLabel.centerYAnchor.constraint(equalTo: windSpeedLabel.centerYAnchor),
            miLabel.centerXAnchor.constraint(equalTo: h12Label.centerXAnchor),
            
            h24Label.centerYAnchor.constraint(equalTo: timeFormatLabel.centerYAnchor),
            h24Label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            timeFormatSwitch.centerYAnchor.constraint(equalTo: timeFormatLabel.centerYAnchor),
            timeFormatSwitch.trailingAnchor.constraint(equalTo: h24Label.leadingAnchor, constant: -10),
            
            h12Label.centerYAnchor.constraint(equalTo: timeFormatLabel.centerYAnchor),
            h12Label.trailingAnchor.constraint(equalTo: timeFormatSwitch.leadingAnchor, constant: -10),
            
            onLabel.centerYAnchor.constraint(equalTo: notificationsLabel.centerYAnchor),
            onLabel.centerXAnchor.constraint(equalTo: h24Label.centerXAnchor),

            notificationsSwitch.centerYAnchor.constraint(equalTo: notificationsLabel.centerYAnchor),
            notificationsSwitch.centerXAnchor.constraint(equalTo: timeFormatSwitch.centerXAnchor),

            offLabel.centerYAnchor.constraint(equalTo: notificationsLabel.centerYAnchor),
            offLabel.centerXAnchor.constraint(equalTo: h12Label.centerXAnchor),
            
            cloudImage1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 37),
            cloudImage1.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -129.6),
            cloudImage1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            cloudImage1.heightAnchor.constraint(equalToConstant: 58.1),
            
            cloudImage2.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -25.8),
            cloudImage2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            cloudImage2.heightAnchor.constraint(equalToConstant: 94.2),
            cloudImage2.widthAnchor.constraint(equalToConstant: 182.3),
            
            cloudImage3.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            cloudImage3.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -95),
            cloudImage3.heightAnchor.constraint(equalToConstant: 65.1),
            cloudImage3.widthAnchor.constraint(equalToConstant: 216.8)
        ])
    }
    
    private func setupSwitches() {
        
        (UserDefaults.standard.value(forKey: "temp-units") as? String == "celsius") ? (tempSwitch.isOn = true) : (tempSwitch.isOn = false)
        
        (UserDefaults.standard.value(forKey: "speed-units") as? String == "km") ? (windSpeedSwitch.isOn = true) : (windSpeedSwitch.isOn = false)
        
        (UserDefaults.standard.value(forKey: "time-units") as? String == "24h") ? (timeFormatSwitch.isOn = true) : (timeFormatSwitch.isOn = false)
        
        UserDefaults.standard.bool(forKey: "isNotificationOn") ? (notificationsSwitch.isOn = true) : (notificationsSwitch.isOn = false)
    }
    
    // MARK: - Actions
    
    @objc private func didTapSettingsButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func didTapTempSwitch() {
        if tempSwitch.isOn {
            UserDefaults.standard.set("celsius", forKey: "temp-units")
        } else {
            UserDefaults.standard.set("fahrenheit", forKey: "temp-units")
        }
    }
    
    private func didTapWindSwitch() {
        if windSpeedSwitch.isOn {
            UserDefaults.standard.set("km", forKey: "speed-units")
        } else {
            UserDefaults.standard.set("mi", forKey: "speed-units")
        }
    }
    
    private func didTapTimeSwitch() {
        if timeFormatSwitch.isOn {
            UserDefaults.standard.set("24h", forKey: "time-units")
        } else {
            UserDefaults.standard.set("12h", forKey: "time-units")
        }
    }
    
    private func didTapNotificationsSwitch() {
        if notificationsSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "isNotificationOn")
            AlertModel.shared.okActionAlert(title: "Attention", message: "Notifications enabled")
        } else {
            UserDefaults.standard.set(false, forKey: "isNotificationOn")
            AlertModel.shared.okActionAlert(title: "Attention", message: "Notifications disabled")
        }
    }
    
}
