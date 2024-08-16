//
//  NoteListPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 12.08.2024.
//

import Foundation

protocol NotePresenterProtocol: AnyObject {
    func uploadImage(image: Data)
    func createNote(title: String, text: String, image: Data?)
    func updateNote(noteId: String, title: String, description: String, imageData: Data?)
}

final class NotePresenter: NotePresenterProtocol {
    private let noteManager = NoteFirebaseManager()
    
    weak var view: NoteViewProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
    }
    
    func createNote(title: String, text: String, image: Data?) {
        noteManager.createNote(title: title, text: text, imageData: image)
    }
    
    func updateNote(noteId: String, title: String, description: String, imageData: Data?) {
        noteManager.updateNote(noteId: noteId, title: title, description: description, imageData: imageData)
    }
    
    func uploadImage(image: Data) {
        
    }
}
