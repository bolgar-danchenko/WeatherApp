//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DetailsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    var hourlyModels = [HourlyWeatherEntry]()
    
    // MARK: - Properties
    
    private lazy var backArrow: UIButton = {
        let backArrow = UIButton()
        backArrow.setImage(UIImage(named: "backArrow"), for: .normal)
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return backArrow
    }()
    
    private lazy var backLabel: UILabel = {
        let backLabel = UILabel()
        backLabel.text = "Forecast for 48 hours"
        backLabel.font = Styles.rubikRegular16Font
        backLabel.textColor = Styles.settingsGrayColor
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        return backLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(coordinator: Coordinator, hourlyModels: [HourlyWeatherEntry]) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.hourlyModels = hourlyModels
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
        tuneTableView()
    }
    
    private func setupSubview() {
        view.addSubview(backArrow)
        view.addSubview(backLabel)
        view.addSubview(locationLabel)
        view.addSubview(tableView)
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
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Styles.darkBlueColor
        tableView.allowsSelection = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
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
            
            tableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return hourlyModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
            cell.configure(with: hourlyModels[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 10
        } else {
            return 160
        }
    }
}
