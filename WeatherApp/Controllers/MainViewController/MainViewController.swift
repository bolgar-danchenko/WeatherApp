//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 03.01.2023.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    private var pageController: PageViewController?
    
    // MARK: - Subviews
    
    private lazy var addLocationButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pin"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
        return menuBarItem
    }()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "menu-button"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 26).isActive = true
    
        return menuBarItem
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.preferredIndicatorImage = UIImage(systemName: "circle")
        if #available(iOS 16.0, *) {
            pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
        } else {
            // Fallback on earlier versions
        }
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.newLocationHandler = { location in
            
            WeatherManager.shared.requestWeather(for: location)
            
            self.pageController?.addWeatherController(location: location)
            self.pageControl.numberOfPages += 1
            self.pageController?.goToController(with: location)
        }
        
        checkOnboardingStatus()
        
        setupNavigationBar()
        setupLayout()
    }
    
    private func checkOnboardingStatus() {
        if !UserDefaults.standard.bool(forKey: "seen-onboarding") {
            navigationController?.pushViewController(OnboardingViewController(), animated: true)
        } else {
            LocationManager.shared.getUserLocation()
        }
    }
    
    private func setTitle(location: CLLocation) {
        DispatchQueue.main.async {
            LocationManager.shared.resolveLocationName(with: location) { locationName in
                guard let locationName = locationName else { return }
                self.title = locationName
                UserDefaults.standard.set(locationName, forKey: "current_title")
            }
        }
    }
    
    // MARK: - Layout
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "RubikRoman-Regular", size: 18) ?? UIFont()]
        title = "Current Location"
        
        navigationItem.rightBarButtonItem = addLocationButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    private func setupLayout() {
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        addChild(pageVC)
        pageVC.pageViewControllerDelegate = self
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageVC.view)
        pageVC.view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.leadingAnchor.constraint(equalTo: pageVC.view.leadingAnchor, constant: 16),
            pageControl.trailingAnchor.constraint(equalTo: pageVC.view.trailingAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: pageVC.view.centerXAnchor)
        ])
        
        pageController = pageVC
    }
    
    // MARK: - Actions
    
    @objc private func addLocation() {
        let alert = UIAlertController(title: "Add Location", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "City or territory..."
        alert.addAction(UIAlertAction(title: "Add", style: .default) {_ in
            guard let userInput = alert.textFields?.first?.text, !userInput.isEmpty else { return }
            
            LocationManager.shared.getLocationFromString(with: userInput)
        })
        self.present(alert, animated: true)
    }
    
    @objc private func didTapSettings() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}

// MARK: - Delegate

extension MainViewController: PageViewControllerDelegate {
    
    func pageViewController(pageVC: PageViewController, didUpdatePageIndex index: Int) {
        DispatchQueue.main.async {
            self.pageControl.currentPage = index
        }
        guard let weatherController = pageVC.currentViewController() as? WeatherViewController,
        let location = weatherController.location else { return }
        setTitle(location: location)
    }
}
