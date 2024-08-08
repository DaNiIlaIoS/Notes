//
//  SignInPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import Foundation

protocol SignInPresenterProtocol: AnyObject {
    func checkUserData(email: String?, password: String?)
}

final class SignInPresenter: SignInPresenterProtocol {
    private let firebaseManager = SignInFirebaseManager()
    weak var view: SignInViewProtocol?
    
    init(view: SignInViewProtocol) {
        self.view = view
    }
    
    func checkUserData(email: String?, password: String?) {
        guard let email = email,
              let password = password else { 
                  self.view?.showError(message: "Please fill in all fields")
                  return
              }
        
        let userData = UserData(email: email, password: password)
        
        self.firebaseManager.signIn(userData: userData) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    NotificationCenter.default.post(Notification(name: Notification.Name(.setProfileController)))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.view?.showError(message: failure.localizedDescription)
            }
        }
    }
}
