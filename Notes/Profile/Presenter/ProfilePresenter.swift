//
//  ProfilePresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import Foundation
import FirebaseAuth

protocol ProfilePresenterProtocol: AnyObject {
    var email: String? { get }
    
    func uploadImage(image: Data)
    func getUserData()
    func signOut()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private let appModel = AppModel()
    private let firebaseManager = ProfileFirebaseManager()
    weak var view: ProfileViewProtocol?
    
    let email: String? = Auth.auth().currentUser?.email
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func uploadImage(image: Data) {
        firebaseManager.uploadImage(image: image)
    }
    
    func getUserData() {
        firebaseManager.getUserData { [weak self] user in
            switch user {
            case .success(let user):
                self?.view?.setUserData(imageUrl: user.imageUrl, name: user.name, birthday: user.birthday)
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        appModel.signOut()
    }
}
