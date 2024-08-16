//
//  CustomAlertController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 16.08.2024.
//

import UIKit

struct CustomAlertController {
    static func createAlertController(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        return alertController
    }
}
