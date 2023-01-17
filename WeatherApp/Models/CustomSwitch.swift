//
//  CustomSwitch.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 17.01.2023.
//

import Foundation
import UIKit

class CustomSwitch: UISwitch {
    
    private let switchAction: () -> ()
    
    init(action: @escaping () -> ()) {
        self.switchAction = action
        super.init(frame: .zero)
        
        backgroundColor = Styles.settingsPinkColor
        onTintColor = Styles.darkBlueColor
        layer.cornerRadius = 15
        isOn = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        sizeToFit()
        addTarget(self, action: #selector(didTapButton), for: .valueChanged)
        self.center = center
    }
    
    @objc func didTapButton() {
        switchAction()
    }
}
