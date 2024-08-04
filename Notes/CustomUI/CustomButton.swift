//
//  CustomButton.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomButton {
    static func createBigButton(title: String, action: UIAction? = nil) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    static func createSmallButton(title: String, action: UIAction? = nil) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

