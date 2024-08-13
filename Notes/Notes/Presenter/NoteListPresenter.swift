//
//  NoteListPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 13.08.2024.
//

import Foundation

protocol NoteListPresenterProtocol: AnyObject {
    var notes: [Note] { get set }
    
    func getNotes()
}

final class NoteListPresenter: NoteListPresenterProtocol {
    private let noteManager = NoteFirebaseManager()
    
    var notes: [Note] = []
    weak var view: NoteListViewProtocol?
    
    init(view: NoteListViewProtocol) {
        self.view = view
        getNotes()
    }
    
    func getNotes() {
        noteManager.getNotes { [weak self] notes in
            self?.notes = notes
            self?.view?.updateNotes()
        }
    }
}
