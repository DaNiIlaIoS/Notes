//
//  SignInFirebaseManager.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import FirebaseAuth

final class SignInFirebaseManager {
    func signIn(userData: UserData, completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().signIn(withEmail: userData.email, password: userData.password) { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            if let _ = result?.user.uid {
                completion(.success(true))
            }
        }
    }
}
