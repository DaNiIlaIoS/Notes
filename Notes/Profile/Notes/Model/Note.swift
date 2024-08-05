//
//  Note.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import Foundation

struct Note {
    let title: String
    let date: String
    let image: String?
    let description: String
    
    static func mockObject() -> [Note] {
        let notes = [Note(title: "Заголовок заметки 1", date: "04.02.24", image: "placeholderImage", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"),
                     Note(title: "Заголовок заметки 2", date: "05.02.24", image: nil, description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"),
                     Note(title: "Заголовок заметки 3", date: "06.02.24", image: nil, description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"),
                     Note(title: "Заголовок заметки 4", date: "07.02.24", image: "placeholderImage", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"),
                     Note(title: "Заголовок заметки 5", date: "08.02.24", image: "placeholderImage", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"),]
        return notes
    }
}
