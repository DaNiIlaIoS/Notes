//
//  SignInViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var titleLabel = CustomLabel.createMainLabel(text: "Авторизация")
    
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Email")
    private lazy var passwordTextField = CustomTextField.createTextField(placeholder: "Пароль", isSecureTextEntry: true)
    
    private lazy var signInButton = CustomButton.createBigButton(title: "Войти", action: UIAction(handler: { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setProfileController)))
    }))
    private lazy var registrationButton = CustomButton.createSmallButton(title: "Регистрация", action: UIAction(handler: { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setRegistrationController)))
    }))
    
    private lazy var textFieldsStack = CustomVStack.createStack(spacing: 20,
                                                                arrangedSubviews: [emailTextField,
                                                                                   passwordTextField],
                                                                distribution: .fillEqually)
    
    private lazy var buttonsStack = CustomVStack.createStack(spacing: 20,
                                                             arrangedSubviews: [signInButton,
                                                                                registrationButton])
    private lazy var mainStack = CustomVStack.createStack(spacing: 40, arrangedSubviews: [titleLabel,
                                                                                          textFieldsStack,
                                                                                          buttonsStack])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
