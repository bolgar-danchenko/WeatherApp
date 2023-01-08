//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 03.01.2023.
//

import UIKit

// MARK: - Protocol

protocol PageViewControllerDelegate: AnyObject {
    
    /// Called when the number of pages is updated
    func pageViewController(pageVC: PageViewController, didUpdatePageCount count: Int)
    
    /// Called when the current index is updated
    func pageViewController(pageVC: PageViewController, didUpdatePageIndex index: Int)
}

// MARK: - PageVC

class PageViewController: UIPageViewController {

    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    private lazy var cities: [UIViewController] = [WeatherViewController(), WeatherViewController(), WeatherViewController() ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        pageViewControllerDelegate?.pageViewController(pageVC: self, didUpdatePageCount: cities.count)
        
        if let firstVC = cities.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
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
            return cities.last
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
            return cities.first
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
