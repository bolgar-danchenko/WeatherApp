//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 30.11.2022.
//

import UIKit

class MainViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Home"
    }
}
