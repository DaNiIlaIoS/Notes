//
//  NoteListPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 12.08.2024.
//

import Foundation

protocol NotePresenterProtocol: AnyObject {
    func createNote(title: String, text: String)
}

final class NotePresenter: NotePresenterProtocol {
    private let noteManager = NoteFirebaseManager()
    weak var view: NoteViewProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
    }
    
    func createNote(title: String, text: String) {
        noteManager.createNote(title: title, text: text)
    }
}
