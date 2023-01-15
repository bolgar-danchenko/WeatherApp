//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 30.11.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - Models
    
    var currentModels = [CurrentWeather]()
    var hourlyModels = [HourlyWeatherEntry]()
    var dailyModels = [DailyWeatherEntry]()
//    var userLocations = LocationManager.shared.userLocations
    
    // MARK: - Bar button items
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
//    init(location: CLLocation) {
//        super.init(nibName: nil, bundle: nil)
//        self.location = location
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(getWeather), name: Notification.Name("WeatherReceived"), object: nil)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            WeatherManager.shared.requestWeatherForLocation()
        }
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
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 35),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func getWeather() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControl.endRefreshing()
        }
        
        self.dailyModels = WeatherManager.shared.dailyModels
        self.currentModels = WeatherManager.shared.currentModels
        self.hourlyModels = WeatherManager.shared.hourlyModels
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView Extensions

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        } else {
            return dailyModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableViewCell.identifier, for: indexPath) as! CurrentTableViewCell
            cell.configure(currentModels: currentModels, dailyModels: dailyModels)
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyTitleTableViewCell.identifier, for: indexPath) as! DailyTitleTableViewCell
//            cell.configure()
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
        
        if indexPath.section == 1 {
            navigationController?.pushViewController(DetailsViewController(hourlyModels: hourlyModels), animated: true)
        } else if indexPath.section == 3 {
            let vc = DailyViewController(dailyModel: dailyModels[indexPath.row])
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 220
        } else if indexPath.section == 1 {
            return 184
        } else if indexPath.section == 2 {
            return 30
        }

        return 66
    }
}
