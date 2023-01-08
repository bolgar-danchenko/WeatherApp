//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 30.11.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        switch type {
        case .settingsButtonTapped:
            var vc: UIViewController & Coordinating = SettingsViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .onboardingNotShown:
            var vc: UIViewController & Coordinating = OnboardingViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .detailsButtonTapped:
            print("detailsButtonTapped")
            var vc: UIViewController & Coordinating = DetailsViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = MainViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
