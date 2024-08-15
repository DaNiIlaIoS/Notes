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
    
    func getNotes(completion: @escaping ([Note]) -> ()) {
        guard let userId = AppModel.userId else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                var notes: [Note] = []
                
                if let document = snapshot?.documents {
                    document.forEach { document in
                        let id = document.documentID
                        let title = document["title"] as! String
                        let description = document["text"] as? String
                        
                        let timestamp = document["date"] as! Timestamp
                        let date = timestamp.dateValue()
                        
                        let isCompleted = document["isCompleted"] as! Bool
                        
                        var imageUrl: URL?
                        if let stringUrl = document["noteImageUrl"] as? String {
                            imageUrl = URL(string: stringUrl)
                        }
                        
                        let oneNote = Note(id: id, title: title, description: description, date: date, imageUrl: imageUrl, isCompleted: isCompleted)
                        notes.append(oneNote)
                    }
                }
                completion(notes)
            }
    }
    
    func deleteNote(noteId: String) {
        guard let userId = AppModel.userId else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .document(noteId)
            .delete { error in
                if let error = error {
                    print("Error when deleting document: \(error.localizedDescription)")
                } else {
                    print("The document was successfully deleted")
                }
            }
        
        Storage.storage().reference()
            .child(userId + "/images/notesImages")
            .child(noteId + ".jpeg")
            .delete { error in
                if let error = error {
                    print("Error when deleting document: \(error.localizedDescription)")
                } else {
                    print("The document was successfully deleted")
                }
            }
    }
}
