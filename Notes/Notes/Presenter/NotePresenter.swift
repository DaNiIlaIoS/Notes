//
//  NoteListPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 12.08.2024.
//

import Foundation

protocol NotePresenterProtocol: AnyObject {
    var note: Note? { get set }
    
    func createNote(title: String, text: String, image: Data?)
    func updateNote(noteId: String, title: String, description: String, imageData: Data?)
}

final class NotePresenter: NotePresenterProtocol {
    private let noteManager = NoteFirebaseManager()
    
    weak var view: NoteViewProtocol?
    var note: Note?
    
    init(view: NoteViewProtocol, note: Note? = nil) {
        self.view = view
        self.note = note
    }
    
    func createNote(title: String, text: String, image: Data?) {
        noteManager.createNote(title: title, text: text, imageData: image)
    }
    
    func updateNote(noteId: String, title: String, description: String, imageData: Data?) {
        noteManager.updateNote(noteId: noteId, title: title, description: description, imageData: imageData)
    }
}
