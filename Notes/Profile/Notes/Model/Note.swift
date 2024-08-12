//
//  Note.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import Foundation

struct Note {
    let id: String
    let title: String
    let description: String?
    let date: Date
    let imageUrl: String?
    let isCompleted: Bool
}
