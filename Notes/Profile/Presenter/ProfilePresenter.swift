//
//  ProfilePresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func signOut()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private let appModel = AppModel()
    weak var view: ProfileViewProtocol?
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func signOut() {
        appModel.signOut()
    }
}
