//
//  NoteFirebaseManager.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 12.08.2024.
//

import Foundation
import Firebase
import FirebaseStorage

final class NoteFirebaseManager {
    func createNote(title: String, text: String, imageData: Data?) {
        guard let userId = AppModel.userId else { return }
        let noteId = UUID().uuidString
        let noteData: [String: Any] = ["title": title, "text": text, "date": Date(), "isCompleted": false]
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .document(noteId)
            .setData(noteData)
        
        if let image = imageData {
            uploadImage(image: image, id: noteId)
        }
        
    }
    
    func uploadImage(image: Data, id: String) {
        guard let userId = AppModel.userId else { return }
        
        let imageName = "noteImage"
        let ref = Storage.storage().reference().child(userId + "/images").child("notesImages").child(id + ".jpeg")
        
        uploadOneImage(image: image, storage: ref) { [weak self] result in
            switch result {
            case .success(let url):
                print(url)
                self?.setNoteImage(stringUrl: url.absoluteString, noteId: id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setNoteImage(stringUrl: String, noteId: String) {
        guard let userId = AppModel.userId else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .document(noteId)
            .setData(["noteImageUrl": stringUrl], merge: true)
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
