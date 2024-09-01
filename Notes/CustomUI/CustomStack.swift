//
//  CustomVStack.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomStack {
    static func createVStack(spacing: CGFloat, arrangedSubviews: [UIView], distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = distribution
        stack.alignment = alignment
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubviews(arrangedSubviews)
        return stack
    }
    
    static func createHStack(spacing: CGFloat, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = distribution
        stack.alignment = alignment
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
