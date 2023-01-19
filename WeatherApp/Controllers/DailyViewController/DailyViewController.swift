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
    
    override var title: String? {
        didSet {
            locationLabel.text = title
        }
    }
    
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
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        
        setupSubview()
        tuneCollectionView()
        setupConstraints()
        setupDailyView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollCollectionView()
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setupSubview() {
        view.addSubview(backLabel)
        view.addSubview(backArrow)
        view.addSubview(locationLabel)
        view.addSubview(dailyView)
        view.addSubview(collectionView)
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
            
            collectionView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            
            dailyView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            dailyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Private
    
    private func tuneCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
    }
    
    private func scrollCollectionView() {
        let indexPath = IndexPath(row: selectedDay, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func setupDailyView() {
        dailyView.removeFromSuperview()
        dailyView = DailyView(dailyModel: dailyModels[selectedDay])
        dailyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dailyView)
        setupConstraints()
    }
}

extension DailyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath) as! ButtonsCollectionViewCell
        cell.configure(name: WeatherManager.shared.getTime(date: dailyModels[indexPath.row].time, format: TimeFormat.dayAndDate.rawValue))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = indexPath.row
        setupDailyView()
    }
}

