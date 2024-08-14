//
//  RegistrationFirebaseManager.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 06.08.2024.
//

import Foundation
import FirebaseAuth
import Firebase

final class RegistrationFirebaseManager {
    func createUser(user: UserRegData, completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            if let userId = result?.user.uid {
                //                result?.user.sendEmailVerification()
                self?.setUserData(userId: userId, name: user.name, birthday: user.birthday, password: user.password)
                completion(.success(true))
            }
        }
    }
    
    private func setUserData(userId: String, name: String, birthday: String, password: String) {
        let userData: [String: Any] = ["name": name, "birthday": birthday, "password": password]
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(userData) { error in
                print("User is added")
            }
    }
}
