//
//  SegmentedViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 15.01.2023.
//

import UIKit

class DailyViewController: UIViewController {
    
    var dailyModels: [DailyWeatherEntry]
    var selectedDay: Int
    
    var segmentedControlButtons: [UIButton] = []
    
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var dailyView: UIView = {
        let view = WeatherSummary(dailyModel: dailyModels[selectedDay])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    init(dailyModels: [DailyWeatherEntry], selectedDay: Int) {
        self.dailyModels = dailyModels
        self.selectedDay = selectedDay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setButtons()
        configureCustomSegmentedControl()
        setupSubview()
        setupConstraints()
        setupDailyView()
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setupSubview() {
        view.addSubview(backLabel)
        view.addSubview(backArrow)
        view.addSubview(locationLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(dailyView)
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
            
            scrollView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 36),
            
            dailyView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40),
            dailyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Private
    
    private func setLocation() {
        guard let currentLocation = LocationManager.shared.currentLocation else { return }
        
        DispatchQueue.main.async {
            LocationManager.shared.resolveLocationName(with: currentLocation) { locationName in
                guard let locationName = locationName else { return }
                self.locationLabel.text = locationName
            }
        }
    }
    
    private func setButtons() {
        for day in dailyModels {
            let name = WeatherManager.shared.getTime(date: day.time, format: TimeFormat.dayAndDate.rawValue)
            let button = UIButton()
            button.setTitle(name, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 105).isActive = true
            segmentedControlButtons.append(button)
        }
    }
    
    private func configureCustomSegmentedControl() {
        segmentedControlButtons.forEach { $0.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .touchUpInside) }
        segmentedControlButtons[selectedDay].backgroundColor = Styles.darkBlueColor
        segmentedControlButtons[selectedDay].setTitleColor(.white, for: .normal)
    }
    
    @objc private func handleSegmentedControlButtons(sender: UIButton) {
        
        for button in segmentedControlButtons {
            if button == sender {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.backgroundColor = Styles.darkBlueColor
                    button.setTitleColor(.white, for: .normal)
                }
                if let index = segmentedControlButtons.firstIndex(of: button) {
                    selectedDay = index
                    
                    setupDailyView()
                }
                
                
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.backgroundColor = .white
                    button.setTitleColor(.black, for: .normal)
                }
            }
        }
    }
    
    private func setupDailyView() {
        dailyView.removeFromSuperview()
        dailyView = DailyView(dailyModel: dailyModels[selectedDay])
        dailyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dailyView)
        setupConstraints()
    }
}
