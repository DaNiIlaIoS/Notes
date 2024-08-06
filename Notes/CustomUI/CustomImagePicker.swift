//
//  CustomImagePicker.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 06.08.2024.
//

import UIKit

struct CustomImagePicker {
    static func createImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = delegate
        return picker
    }
}
