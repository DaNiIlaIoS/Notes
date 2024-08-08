//
//  AppModel.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import Foundation
import FirebaseAuth

final class AppModel {
    static var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func isUserLogin() -> Bool {
        return AppModel.userId != nil ? true : false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(Notification(name: Notification.Name(.setSignInController)))
        } catch {
            print(error.localizedDescription)
        }
    }
}
