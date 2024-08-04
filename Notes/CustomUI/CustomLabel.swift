//
//  CustomLabel.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomLabel {
    static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
