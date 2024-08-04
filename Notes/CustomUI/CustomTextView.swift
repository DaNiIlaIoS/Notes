//
//  CustomTextView.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomTextView {
    static func createTextView(placeholder: String) -> UITextView {
        let textView = UITextView()
        textView.text = placeholder
        textView.textColor = UIColor.systemGray3
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return textView
    }
    
    
}
