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
    
    func uploadImage(image: Data) {
        
    }
}
