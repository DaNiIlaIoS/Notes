//
//  CustomLabel.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomLabel {
    static func createMainLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createSubLabel(text: String, alignment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createDateLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
