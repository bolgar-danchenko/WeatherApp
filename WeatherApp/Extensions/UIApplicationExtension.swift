//
//  UIApplicationExtension.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 18.01.2023.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.connectedScenes
          .filter({$0.activationState == .foregroundActive})
          .compactMap({$0 as? UIWindowScene})
          .first?.windows
          .filter({$0.isKeyWindow})
          .first?.rootViewController) -> UIViewController? {

        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
