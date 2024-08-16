//
//  Date+Ex.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 13.08.2024.
//

import Foundation

extension Date {
    func formateDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: self)
    }
}
