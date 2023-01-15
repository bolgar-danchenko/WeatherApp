//
//  PageViewControllerDelegate.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 14.01.2023.
//

import Foundation

protocol PageViewControllerDelegate: AnyObject {
    
    /// Called when the number of pages is updated
    func pageViewController(pageVC: PageViewController, didUpdatePageCount count: Int)
    
    /// Called when the current index is updated
    func pageViewController(pageVC: PageViewController, didUpdatePageIndex index: Int)
}
