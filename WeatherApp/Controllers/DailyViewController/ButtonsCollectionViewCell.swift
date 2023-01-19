//
//  ButtonsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 19.01.2023.
//

import UIKit

class ButtonsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ButtonsCollectionViewCell"
    
    // MARK: - Subviews
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.textColor = .blue
            } else {
                label.textColor = .black
            }
        }
    }
    
    // MARK: - Layout
    
    private func setupView() {
        self.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Configure
    
    func configure(name: String) {
        label.text = name
    }
}
