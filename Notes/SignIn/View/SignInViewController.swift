//
//  SignInViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Выберите дату"
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels // Use .compact for a different style
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dateTextField.widthAnchor.constraint(equalToConstant: 200),
            dateTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        setupDatePicker()
    }
    
    private func setupDatePicker() {
        // Создаем тулбар с кнопками
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        toolbar.setItems([cancelButton, doneButton], animated: false)
        
        // Назначаем UIDatePicker как inputView для UITextField
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
    }
    
    @objc private func donePressed() {
        // Форматируем дату и назначаем её текстом для dateTextField
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true) // Закрываем picker
    }
    
    @objc private func cancelPressed() {
        self.view.endEditing(true) // Закрываем picker
    }
}

extension UIBarButtonItem {
    static func flexibleSpace() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}
