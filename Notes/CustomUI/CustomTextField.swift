//
//  CustomTextField.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomTextField {
    static func createTextField(placeholder: String, autocapitalizationType: UITextAutocapitalizationType = .none, isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = autocapitalizationType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }
    
    static func createPasswordTextField(touchDownAction: Selector, touchUpInsideAction: Selector) -> UITextField {
        let showPasswordButton: UIButton = {
            let button = CustomButton.createShowPasswordButton()
            button.addTarget(self, action: touchDownAction, for: .touchDown)
            button.addTarget(self, action: touchUpInsideAction, for: .touchUpInside)
            return button
        }()
        
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        rightViewContainer.addSubview(showPasswordButton)
        
        rightViewContainer.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightViewContainer.widthAnchor.constraint(equalToConstant: 50),
            rightViewContainer.heightAnchor.constraint(equalToConstant: 50),
            
            showPasswordButton.trailingAnchor.constraint(equalTo: rightViewContainer.trailingAnchor, constant: -15),
            showPasswordButton.centerYAnchor.constraint(equalTo: rightViewContainer.centerYAnchor),
        ])
        
        let textField = CustomTextField.createTextField(placeholder: "Пароль", isSecureTextEntry: true)
        textField.rightView = rightViewContainer
        textField.rightViewMode = .always
        return textField
    }
}
