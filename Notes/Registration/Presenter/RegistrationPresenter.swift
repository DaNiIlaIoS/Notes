//
//  RegistrationPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 06.08.2024.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func registerUser(name: String?, birthday: String?, email: String?, password: String?)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    private let registrationManager = RegistrationFirebaseManager()
    weak var view: RegistrationViewProtocol?
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func registerUser(name: String?, birthday: String?, email: String?, password: String?) {
        guard let name = name, let birthday = birthday, let email = email, let password = password else {
            print("User data is nil")
            return
        }
        guard !name.isEmpty, !birthday.isEmpty, !email.isEmpty, !password.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        let regData = UserRegData(name: name, birthday: birthday, email: email, password: password)
        
        registrationManager.createUser(user: regData) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    NotificationCenter.default.post(Notification(name: Notification.Name(.setSignInController)))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.view?.showError(message: failure.localizedDescription)
            }
        }
        
    }
}
