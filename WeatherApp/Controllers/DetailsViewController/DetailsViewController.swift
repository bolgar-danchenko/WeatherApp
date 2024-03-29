//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var hourlyModels = [HourlyWeatherEntry]()
    
    override var title: String? {
        didSet {
            locationLabel.text = title
        }
    }
    
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
        backLabel.text = "Forecast for 24 hours"
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
    
    private lazy var chartView: UIView = {
        let view = ChartView(hourlyModels: hourlyModels)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(hourlyModels: [HourlyWeatherEntry]) {
        super.init(nibName: nil, bundle: nil)
        
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
    
    // MARK: - Layout
    
    private func setupSubview() {
        view.addSubview(backArrow)
        view.addSubview(backLabel)
        view.addSubview(locationLabel)
        view.addSubview(chartView)
        view.addSubview(tableView)
    }
    
    private func tuneTableView() {
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = Styles.darkBlueColor
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
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
            
            chartView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - TableView Delegate & DataSource

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        cell.configure(with: hourlyModels[indexPath.row])
        
        let numberOfRows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
        cell.hidesBottomSeparator = indexPath.row == numberOfRows - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
