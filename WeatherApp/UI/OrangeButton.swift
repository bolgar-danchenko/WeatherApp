//
//  OrangeButton.swift
//  WeatherApp
//
//  Created by Konstantin Bolgar-Danchenko on 01.12.2022.
//

import Foundation
import UIKit

class OrangeButton: UIButton {
    
    private let buttonAction: () -> ()
    
    init(action: @escaping () -> (), color: UIColor, title: String, titleColor: UIColor, font: UIFont) {
        self.buttonAction = action
        super.init(frame: .zero)
        
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        sizeToFit()
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.center = center
    }
    
    @objc func didTapButton() {
        buttonAction()
    }
}
