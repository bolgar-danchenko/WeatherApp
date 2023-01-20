//
//  AlertModel.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 17.01.2023.
//

import Foundation
import UIKit

class AlertModel {

    static let shared = AlertModel()

    func okActionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
