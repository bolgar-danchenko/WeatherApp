//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class OnboardingViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    // MARK: - Subviews
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var titelLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikSemibold16Font, color: .white)
        label.text = "WeatherApp requires access to your location"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstTextLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.text = "Allow access to get more accurate weather forecast while moving"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondTextLabel: UILabel = {
        let label = UILabel()
        label.applyStyle(font: Styles.rubikRegular14Font, color: .white)
        label.text = "You can change your decision every time in Settings"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yesButton = CustomButton(action: didTapYes, color: Styles.orangeButtonColor, title: "USE DEVICE LOCATION", titleColor: .white, font: Styles.rubikMedium16Font)
    
    private lazy var noButton = CustomButton(action: didTapNo, color: .clear, title: "ADD LOCATIONS MANUALLY", titleColor: .white, font: Styles.rubikRegular16Font)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Styles.darkBlueColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        view.addSubview(logo)
        view.addSubview(titelLabel)
        view.addSubview(firstTextLabel)
        view.addSubview(secondTextLabel)
        view.addSubview(yesButton)
        yesButton.setup()
        noButton.setup()
        view.addSubview(noButton)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            noButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -77),
            noButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            noButton.heightAnchor.constraint(equalToConstant: 21),
            noButton.widthAnchor.constraint(equalToConstant: 250),
            
            yesButton.bottomAnchor.constraint(equalTo: noButton.topAnchor, constant: -25),
            yesButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 18),
            yesButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17),
            yesButton.heightAnchor.constraint(equalToConstant: 40),
            
            secondTextLabel.bottomAnchor.constraint(equalTo: yesButton.topAnchor, constant: -44),
            secondTextLabel.heightAnchor.constraint(equalToConstant: 36),
            secondTextLabel.widthAnchor.constraint(equalToConstant: 314),
            secondTextLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            firstTextLabel.bottomAnchor.constraint(equalTo: secondTextLabel.topAnchor, constant: -14),
            firstTextLabel.heightAnchor.constraint(equalToConstant: 36),
            firstTextLabel.widthAnchor.constraint(equalToConstant: 314),
            firstTextLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            titelLabel.bottomAnchor.constraint(equalTo: firstTextLabel.topAnchor, constant: -40),
            titelLabel.heightAnchor.constraint(equalToConstant: 63),
            titelLabel.widthAnchor.constraint(equalToConstant: 322),
            titelLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            logo.bottomAnchor.constraint(equalTo: titelLabel.topAnchor, constant: -46),
            logo.heightAnchor.constraint(equalToConstant: 196),
            logo.widthAnchor.constraint(equalToConstant: 180),
            logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func didTapYes() {
        LocationManager.shared.getUserLocation()
        UserDefaults.standard.set(true, forKey: "seen-onboarding")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNo() {
        UserDefaults.standard.set(true, forKey: "seen-onboarding")
        navigationController?.popViewController(animated: true)
    }
}
