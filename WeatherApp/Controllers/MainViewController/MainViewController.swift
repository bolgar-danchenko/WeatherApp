//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 03.01.2023.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    private var pageViewController: PageViewController?
    
    // MARK: - Subviews
    
    private lazy var addLocationButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
        return menuBarItem
    }()
    
    private lazy var deleteLocationButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(deleteLocation), for: .touchUpInside)
        
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
    
    private lazy var noLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "No locations added"
        label.applyStyle(font: Styles.rubikMedium18Font, color: .lightGray)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.backgroundColor = .white
        checkOnboardingStatus()
        setupNavigationBar()
        setupSubview()
        updateWeather()
        setupPageViewController()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(getWeather), name: Notification.Name("WeatherReceived"), object: nil)
        
        if !LocationManager.shared.isLocationAllowed() {
            WeatherManager.shared.updateCachedData { [weak self] cityWeatherArray in
                let cities = cityWeatherArray.compactMap { cityWeather in
                    let city = City(cityName: cityWeather.cityName, location: cityWeather.location)
                    return city
                }
                self?.pageViewController?.setCities(cities: cities)
                self?.pageControl.numberOfPages = cities.count
            }
        }
    }
    
    // MARK: - Layout
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "RubikRoman-Regular", size: 18) ?? UIFont()]
        title = "No Location"
        
        navigationItem.rightBarButtonItems = [addLocationButton, deleteLocationButton]
        navigationItem.leftBarButtonItem = settingsButton
        
        setupDeleteButton()
    }
    
    private func setupDeleteButton() {
        let controllersCount = pageViewController?.cities.count ?? 0
        
        if controllersCount == 0 || controllersCount == 1 {
            deleteLocationButton.isHidden = true
        } else {
            deleteLocationButton.isHidden = false
        }
    }
    
    private func setupPageViewController() {
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
        
        pageViewController = pageVC
    }
    
    private func setupSubview() {
        view.addSubview(noLocationLabel)
        
        NSLayoutConstraint.activate([
            noLocationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noLocationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    // MARK: - Private
    
    private func checkOnboardingStatus() {
        if !UserDefaults.standard.bool(forKey: "seen-onboarding") {
            navigationController?.pushViewController(OnboardingViewController(), animated: true)
            WeatherManager.shared.configureSettings()
        } else {
            LocationManager.shared.getUserLocation()
        }
    }
    
    private func setTitle(cityName: String) {
        DispatchQueue.main.async {
            self.title = cityName
        }
    }
    
    @objc private func getWeather() {
        
        let pageControllersCount = self.pageViewController?.cities.count ?? 0
        
        if self.pageViewController?.viewControllers?.isEmpty == true || pageControllersCount < WeatherManager.shared.cityWeatherList.count {
            let cities = WeatherManager.shared.cityWeatherList.compactMap { cityWeather in
                let city = City(cityName: cityWeather.cityName, location: cityWeather.location)
                return city
            }
            self.pageViewController?.setCities(cities: cities)
            self.pageControl.numberOfPages = cities.count
        }
    }
    
    private func updateWeather() {
        LocationManager.shared.newLocationHandler = { location in

            WeatherManager.shared.requestWeather(for: location)
            location.cityName { [weak self] result in
                switch result {
                case .success(let cityName):
                    guard !WeatherManager.shared.cityWeatherList.contains(where: { $0.cityName == cityName} ) else { return }
                    let city = City(cityName: cityName, location: location)

                    if self?.pageViewController?.addWeatherController(city: city) == true {
                        self?.pageControl.numberOfPages += 1
                        self?.pageViewController?.goToController(with: city)
                        DispatchQueue.main.async {
                            self?.setupDeleteButton()
                        }
                    }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func addLocation() {
        let alert = UIAlertController(title: "Add Location", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "City or territory..."
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let userInput = alert.textFields?.first?.text, !userInput.isEmpty else {
                AlertModel.shared.okActionAlert(title: "Attention", message: "Location cannot be ampty")
                return
            }
            if LocationManager.shared.newLocationHandler != nil {
                LocationManager.shared.getLocationFromString(with: userInput)
            } else {
                LocationManager.shared.getLocationFromString(with: userInput)
                self?.updateWeather()
                self?.setupPageViewController()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc private func deleteLocation() {
        
        guard let title = title else { return }
        
        if pageControl.numberOfPages > 1 {
            CoreDataManager.shared.removeCity(cityName: title)
            pageViewController?.removeCurrentController()
            pageControl.numberOfPages -= 1
        }
        
        setupDeleteButton()
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
              let cityName = weatherController.city?.cityName else { return }
        setTitle(cityName: cityName)
    }
}
