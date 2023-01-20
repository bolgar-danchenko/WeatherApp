//
//  DailyTitleTableViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class DailyTitleTableViewCell: UITableViewCell {
    
    static let identifier = "DailyTitleTableViewCell"
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Forecast"
        label.applyStyle(font: Styles.rubikMedium18Font, color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var daysButton = CustomButton(action: didTapDaysButton, color: .clear, title: "25 Days", titleColor: .black, font: Styles.rubikRegular16Font)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
//        daysButton.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
//        contentView.addSubview(daysButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
//            daysButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            daysButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
//            daysButton.heightAnchor.constraint(equalToConstant: 20),
//            daysButton.widthAnchor.constraint(equalToConstant: 85)
            
        ])
    }
    
    // MARK: - Configure
    
//    func configure() {
//        let myAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
//        let attributeString = NSMutableAttributedString(string: "25 days", attributes: myAttributes)
//        daysButton.setAttributedTitle(attributeString, for: .normal)
//        daysButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
//    }
    
//    @objc func didTapDaysButton() {
//        print("Did tap days button")
//    }
}
