//
//  PageViewControllerDelegate.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 14.01.2023.
//

import Foundation

protocol PageViewControllerDelegate: AnyObject {
    /// Called when the current index is updated
    func pageViewController(pageVC: PageViewController, didUpdatePageIndex index: Int)
}
