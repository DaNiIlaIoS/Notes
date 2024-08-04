//
//  CustomVStack.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomVStack {
    static func createStack(spacing: CGFloat, arrangedSubviews: [UIView], distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = distribution
        stack.alignment = .fill
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubviews(arrangedSubviews)
        return stack
    }
}
