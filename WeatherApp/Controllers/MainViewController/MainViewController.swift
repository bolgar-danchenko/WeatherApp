//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 30.11.2022.
//

import UIKit

class MainViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    // MARK: - Models
    
    var currentModels = [CurrentWeather]()
    var hourlyModels = [HourlyWeatherEntry]()
    var dailyModels = [DailyWeatherEntry]()
    
    // MARK: - Bar button items
    
    private lazy var addLocationButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pin"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
        return menuBarItem
    }()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "menu-button"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 26).isActive = true
    
        return menuBarItem
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "RubikRoman-Regular", size: 18) ?? UIFont()]
        title = "Current Location"
        
        checkOnboardingStatus()
        
        navigationItem.rightBarButtonItem = addLocationButton
        navigationItem.leftBarButtonItem = settingsButton
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(setTitle), name: Notification.Name("WeatherReceived"), object: nil)
        nc.addObserver(self, selector: #selector(getWeather), name: Notification.Name("WeatherReceived"), object: nil)
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(tableView)
        
        tuneTableView()
        setupConstraints()
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        
        tableView.register(CurrentTableViewCell.self, forCellReuseIdentifier: CurrentTableViewCell.identifier)
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(DailyTitleTableViewCell.self, forCellReuseIdentifier: DailyTitleTableViewCell.identifier)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    // MARK: - Private methods
    
    private func checkOnboardingStatus() {
        if !UserDefaults.standard.bool(forKey: "seen-onboarding") {
            coordinator?.eventOccurred(with: .onboardingNotShown)
        } else {
            LocationManager.shared.getUserLocation()
        }
    }
    
    // MARK: - Actions
    
    @objc private func addLocation() {
        let alert = UIAlertController(title: "Add Location", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "City or territory..."
        alert.addAction(UIAlertAction(title: "Add", style: .default) {_ in
            guard let userInput = alert.textFields?.first?.text else { return }
            print(userInput)
        })
        self.present(alert, animated: true)
    }
    
    @objc private func didTapSettings() {
        coordinator?.eventOccurred(with: .settingsButtonTapped)
    }
    
    @objc func getWeather() {
        self.dailyModels = WeatherManager.shared.dailyModels
        self.currentModels = WeatherManager.shared.currentModels
        self.hourlyModels = WeatherManager.shared.hourlyModels
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func setTitle() {
        guard let currentLocation = LocationManager.shared.currentLocation else { return }
        
        DispatchQueue.main.async {
            LocationManager.shared.resolveLocationName(with: currentLocation) { locationName in
                guard let locationName = locationName else { return }
                print(locationName)
                self.title = locationName
            }
        }
    }
}

// MARK: - TableView Extensions

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            // 1 cell that is CollectionTableViewCell
            return 1
        } else if section == 1 {
            // 1 cell that is CollectionTableViewCell
            return 1
        } else if section == 2 {
            // 1 cell with header for daily weather
            return 1
        }
        return dailyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableViewCell.identifier, for: indexPath) as! CurrentTableViewCell
            cell.configure(with: currentModels)
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyTitleTableViewCell.identifier, for: indexPath) as! DailyTitleTableViewCell
            cell.configure()
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
            cell.configure(with: dailyModels[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if indexPath.section == 1 {
//            performSegue(withIdentifier: "ShowDetails", sender: nil)
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 220
        } else if indexPath.section == 1 {
            return 160
        } else if indexPath.section == 2 {
            return 30
        }

        return 66
    }
}
