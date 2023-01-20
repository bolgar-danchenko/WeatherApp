//
//  TimeFormat.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 18.01.2023.
//

import Foundation

enum TimeFormat: String {
    case time24 = "HH:mm" // 12:00
    case time12 = "h a" // 3 PM
    case date = "d/MM" // 25/11
    case dateAndTime24 = "MMM d, HH:mm" // Nov 25, 15:12
    case dateAndTime12 = "MMM d, h:mm a" // Nov 26, 3:12 PM
    case dayAndDate = "E, dd/MM" // Wed, 25/11
}
