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
    
//    func eventOccurred(with type: Event) {
//
//    }
    
    func start() {
        var vc: UIViewController & Coordinating = MainViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
