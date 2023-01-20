//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 03.01.2023.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController {

    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    private(set) var cities: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
    }
    
    func currentViewController() -> UIViewController? {
        let firstVC = viewControllers?.first
        return firstVC
    }
    
    func goToController(with city: City) {
        
        guard let searchedController = cities.first(where: { ($0 as? WeatherViewController)?.city?.cityName == city.cityName }) else { return }
        
        setViewControllers([searchedController], direction: .forward, animated: true)
        
        if let index = cities.firstIndex(of: searchedController) {
            pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
        }
    }
    
    func addWeatherController(city: City) -> Bool {
        
        guard cities.first(where: { ($0 as? WeatherViewController)?.city?.cityName == city.cityName }) == nil else { return false }
        
        let weatherVC = WeatherViewController()
        weatherVC.city = city
        cities.append(weatherVC)
        
        guard viewControllers?.isEmpty == true else { return true }
        
        if let firstVC = cities.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
            
            if let index = cities.firstIndex(of: firstVC) {
                pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
            }
        }
        return true
    }
    
    func removeCurrentController() {
        self.cities.removeAll { vc in
            (vc as? WeatherViewController)?.city?.cityName == (self.viewControllers?.first as? WeatherViewController)?.city?.cityName
        }
        
        if let firstVC = cities.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
            
            if let index = cities.firstIndex(of: firstVC) {
                pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
            }
        }
    }
    
    func setCities(cities: [City]) {
        
        self.cities.removeAll()
        
        cities.forEach { [weak self] city in
            let weatherVC = WeatherViewController()
            weatherVC.city = city
            self?.cities.append(weatherVC)
        }
        
        if let firstVC = self.cities.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
            
            if let index = self.cities.firstIndex(of: firstVC) {
                pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
            }
        }
    }
}

// MARK: - DataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = cities.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard cities.count > previousIndex else {
            return nil
        }
        
        return cities[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = cities.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        let citiesCount = cities.count
        
        guard citiesCount != nextIndex else {
            return nil
        }
        
        guard citiesCount > nextIndex else {
            return nil
        }
        
        return cities[nextIndex]
    }
}

// MARK: - Delegate

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let firstVC = viewControllers?.first,
           let index = cities.firstIndex(of: firstVC) {
            pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
        }
    }
}
