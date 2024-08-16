//
//  RegistrationViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 02.08.2024.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func showError(message: String)
}

class RegistrationViewController: UIViewController, RegistrationViewProtocol {
    
    private lazy var titleLabel = CustomLabel.createMainLabel(text: "Регистрация")
    
    private lazy var nameTextField = CustomTextField.createTextField(placeholder: "Имя Фамилия")
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private lazy var dateTextField: UITextField = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        let spaceButton = UIBarButtonItem(systemItem: .flexibleSpace)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
        let textField = CustomTextField.createTextField(placeholder: "Дата рождения")
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        return textField
    }()
    
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Email")
    
    private lazy var passwordTextField = CustomTextField.createPasswordTextField(touchDownAction: #selector(showPassword), touchUpInsideAction: #selector(hidePassword))
    
    private lazy var registrationButton = CustomButton.createBigButton(title: "Регистрация", action: UIAction(handler: { [weak self] _ in
        
        self?.presenter.registerUser(name: self?.nameTextField.text, birthday: self?.dateTextField.text, email: self?.emailTextField.text, password: self?.passwordTextField.text)
        
    }))
    
    private lazy var haveAccountButton = CustomButton.createSmallButton(title: "Уже есть аккаунт", action: UIAction(handler: { [weak self] _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setSignInController)))
    }))
    
    private lazy var textFieldsStack = CustomVStack.createStack(spacing: 20,
                                                                arrangedSubviews: [nameTextField,
                                                                                   dateTextField,
                                                                                   emailTextField,
                                                                                   passwordTextField],
                                                                distribution: .fillEqually)
    
    private lazy var buttonsStack = CustomVStack.createStack(spacing: 20,
                                                             arrangedSubviews: [registrationButton,
                                                                                haveAccountButton])
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 40,
                                                          arrangedSubviews: [titleLabel,
                                                                             textFieldsStack,
                                                                             buttonsStack])
    
    private var presenter: RegistrationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter = RegistrationPresenter(view: self)
    }
    
    func showError(message: String) {
        let alert = CustomAlertController.createAlertController(message: message)
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        view.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    @objc func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelAction() {
        self.view.endEditing(true)
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hidePassword() {
        // Скрываем пароль, когда кнопка отпускается внутри её границ
        passwordTextField.isSecureTextEntry.toggle()
    }
}
