//
//  Styles.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import UIKit

class Styles {
    
    static let darkBlueColor: UIColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
    static let solitudeColor: UIColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    static let settingsGrayColor: UIColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
    static let orangeButtonColor: UIColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
    static let dateGrayColor: UIColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
    static let summaryDarkGrayColor: UIColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
    
    static let rubikMedium18Font: UIFont = UIFont(name: "RubikRoman-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
    static let rubikRegular12Font: UIFont = UIFont(name: "RubikRoman-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    static let rubikRegular16Font: UIFont = UIFont(name: "RubikRoman-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    static let rubikRegular18Font: UIFont = UIFont(name: "RubikRoman-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
    static let rubikSemibold16Font: UIFont = UIFont(name: "RubikRoman-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16)
    static let rubikRegular14Font: UIFont = UIFont(name: "RubikRoman-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    static let rubikMedium16Font: UIFont = UIFont(name: "RubikRoman-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
    
}

extension UILabel {
    func applyStyle(font: UIFont, color: UIColor) {
        self.font = font
        self.textColor = color
    }
}
