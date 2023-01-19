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
    
    private lazy var labelBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular18Font, color: .black)
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
                labelBackground.backgroundColor = Styles.darkBlueColor
                dateLabel.textColor = .white
            } else {
                labelBackground.backgroundColor = .clear
                dateLabel.textColor = .black
            }
        }
    }
    
    // MARK: - Layout
    
    private func setupView() {
        self.addSubview(labelBackground)
        labelBackground.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelBackground.topAnchor.constraint(equalTo: self.topAnchor),
            labelBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateLabel.centerXAnchor.constraint(equalTo: labelBackground.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: labelBackground.centerYAnchor)
        ])
    }
    
    // MARK: - Configure
    
    func configure(dateLabel: String) {
        self.dateLabel.text = dateLabel
    }
}
