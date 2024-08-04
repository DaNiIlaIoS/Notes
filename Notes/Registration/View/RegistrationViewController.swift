//
//  RegistrationViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 02.08.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private lazy var titleLabel = CustomLabel.createLabel(text: "Регистрация")
    
    private lazy var nameTextField = CustomTextField.createTextField(placeholder: "Имя")
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Email")
    private lazy var passwordTextField = CustomTextField.createTextField(placeholder: "Пароль", isSecureTextEntry: true)
    
    private lazy var textView = CustomTextView.createTextView(placeholder: "О себе (необязательно)")
    private lazy var registrationButton = CustomButton.createBigButton(title: "Регистрация")
    
    private lazy var haveAccountButton = CustomButton.createSmallButton(title: "уже есть аккаунт", action: UIAction(handler: { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setSignInController)))
    }))
    
    private lazy var textFieldsStack = CustomVStack.createStack(spacing: 20,
                                                                arrangedSubviews: [nameTextField,
                                                                                   textView,
                                                                                   emailTextField,
                                                                                   passwordTextField])
    
    private lazy var buttonsStack = CustomVStack.createStack(spacing: 20,
                                                             arrangedSubviews: [registrationButton,
                                                                                haveAccountButton])
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 40,
                                                          arrangedSubviews: [titleLabel,
                                                                             textFieldsStack,
                                                                             buttonsStack])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        
        textView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            //            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}

extension RegistrationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}
