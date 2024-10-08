//
//  SignInViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func showError(message: String)
}

class SignInViewController: UIViewController, SignInViewProtocol {
    
    private lazy var titleLabel = CustomLabel.createMainLabel(text: "Авторизация")
    
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Email")
    private lazy var passwordTextField = CustomTextField.createPasswordTextField(touchDownAction: #selector(showPassword), touchUpInsideAction: #selector(hidePassword))
    
    private lazy var signInButton = CustomButton.createBigButton(title: "Войти", action: UIAction(handler: { [weak self] _ in
        
        self?.presenter.checkUserData(email: self?.emailTextField.text, password: self?.passwordTextField.text)
        
    }))
    
    private lazy var registrationButton = CustomButton.createSmallButton(title: "Регистрация", action: UIAction(handler: { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setRegistrationController)))
    }))
    
    private lazy var textFieldsStack = CustomStack.createVStack(spacing: 20,
                                                                arrangedSubviews: [emailTextField,
                                                                                   passwordTextField],
                                                                distribution: .fillEqually)
    
    private lazy var buttonsStack = CustomStack.createVStack(spacing: 20,
                                                             arrangedSubviews: [signInButton,
                                                                                registrationButton])
    private lazy var mainStack = CustomStack.createVStack(spacing: 40, arrangedSubviews: [titleLabel,
                                                                                          textFieldsStack,
                                                                                          buttonsStack])
    
    
    private var presenter: SignInPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignInPresenter(view: self)
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        view.addSubview(mainStack)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func showError(message: String) {
        let alert = CustomAlertController.createAlertController(message: message)
        present(alert, animated: true)
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hidePassword() {
        // Скрываем пароль, когда кнопка отпускается внутри её границ
        passwordTextField.isSecureTextEntry.toggle()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
}
