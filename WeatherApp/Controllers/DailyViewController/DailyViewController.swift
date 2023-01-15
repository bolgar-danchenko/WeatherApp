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
    
    // MARK: - Lifecycle
    
    init(dailyModel: DailyWeatherEntry) {
        self.dailyModel = dailyModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    private func setupSubview() {
        view.addSubview(backArrow)
        view.addSubview(backLabel)
        view.addSubview(locationLabel)
        view.addSubview(dailyWeatherView)
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
        ])
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
}
