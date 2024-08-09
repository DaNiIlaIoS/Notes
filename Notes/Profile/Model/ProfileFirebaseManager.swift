//
//  PresenterFirebaseManager.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 08.08.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class ProfileFirebaseManager {
    func uploadImage(image: Data) {
        guard let userId = AppModel.userId else { return }
        
        let imageName = "avatar"
        let ref = Storage.storage().reference().child(userId + "/images").child(imageName)
        
        uploadOneImage(image: image, storage: ref) { [weak self] result in
            switch result {
            case .success(let url):
                print(url)
                self?.setUserAvatar(stringUrl: url.absoluteString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> ()) {
        guard let userId = AppModel.userId else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument { snapshot, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                if let document = snapshot {
                    let id = document.documentID
                    let name = document["name"] as? String
                    let birthday = document["birthday"] as? String
                    let avatarUrl = document["avatarUrl"] as? String
                    
                    var url: URL? = nil
                    
                    if let stringUrl = avatarUrl {
                        url = URL(string: stringUrl)
                    }
                    
                    let user = User(id: id, name: name, birthday: birthday, imageUrl: url)
                    
                    completion(.success(user))
                    
                }
            }
    }
    
    private func setUserAvatar(stringUrl: String) {
        guard let userId = AppModel.userId else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["avatarUrl": stringUrl], merge: true)
    }
    
    private func uploadOneImage(image: Data?, storage: StorageReference, completion: @escaping (Result<URL, Error>) -> ()) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        guard let imageData = image else { return }
        
        storage.putData(imageData, metadata: metaData) { meta, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            storage.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
