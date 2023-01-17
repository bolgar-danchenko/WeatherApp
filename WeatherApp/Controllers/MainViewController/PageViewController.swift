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
    
    private var cities: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
    }
    
    func currentViewController() -> UIViewController? {
        let firstVC = viewControllers?.first
        return firstVC
    }
    
    func goToController(with location: CLLocation) {
        
        guard let searchedController = cities.first(where: { ($0 as? WeatherViewController)?.location == location }) else { return }
        
        setViewControllers([searchedController], direction: .forward, animated: true)
        
        if let index = cities.firstIndex(of: searchedController) {
            pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageIndex: index)
        }
    }
    
    func addWeatherController(location: CLLocation) {
        let weatherVC = WeatherViewController()
        weatherVC.location = location
        cities.append(weatherVC)
        
        guard viewControllers?.isEmpty == true else { return }
        
        if let firstVC = cities.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
            
            if let index = cities.firstIndex(of: firstVC) {
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
