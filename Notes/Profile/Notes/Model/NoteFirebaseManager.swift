//
//  NoteFirebaseManager.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 12.08.2024.
//

import Foundation
import Firebase

final class NoteFirebaseManager {
    func createNote(title: String, text: String) {
        guard let userId = AppModel.userId else { return }
        let noteData: [String: Any] = ["title": title, "text": text, "date": Date(), "isCompleted": false]
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .addDocument(data: noteData)
    }
}
