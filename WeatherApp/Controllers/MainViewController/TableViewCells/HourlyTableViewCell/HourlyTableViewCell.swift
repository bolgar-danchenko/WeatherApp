//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class HourlyTableViewCell: UITableViewCell, Coordinating {

    var coordinator: Coordinator?
    
    static let identifier = "HourlyTableViewCell"
    
    var models = [HourlyWeatherEntry]()
    
    private lazy var collectionView: UICollectionView = {
        let viewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var detailsButton = OrangeButton(action: didTapDetailsButton, color: .clear, title: "Forecast for 24 hours", titleColor: .black, font: Styles.rubikRegular16Font)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        tuneCollectionView()
        setupConstraints()
        detailsButton.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneCollectionView() {
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
            
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupView() {
        contentView.addSubview(collectionView)
        contentView.addSubview(detailsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            detailsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            detailsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            detailsButton.heightAnchor.constraint(equalToConstant: 20),
            detailsButton.widthAnchor.constraint(equalToConstant: 300),
            
            collectionView.topAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        
        ])
    }
    
    func configure(with models: [HourlyWeatherEntry]) {
        self.models = models
        collectionView.reloadData()
        
        let myAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "Detailed forecast for 24 hours", attributes: myAttributes)
        detailsButton.setAttributedTitle(attributeString, for: .normal)
        detailsButton.setAttributedTitle(attributeString, for: .normal)
        detailsButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
    }

    @objc func didTapDetailsButton() {
        coordinator?.eventOccurred(with: .detailsButtonTapped)
    }
}

// MARK: - CollectionView Extensions

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(red: 171/255.0, green: 188/255.0, blue: 234/255.0, alpha: 1.0)
        cell.layer.cornerRadius = 22
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(cgColor: CGColor(red: 32/255.0, green: 78/255.0, blue: 199/255.0, alpha: 1.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .clear
    }
}
