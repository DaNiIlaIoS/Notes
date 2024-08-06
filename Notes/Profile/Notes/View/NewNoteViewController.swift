//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

final class NewNoteViewController: UIViewController {
    
    private lazy var titleTextField = CustomTextField.createTextField(placeholder: "Заголовок")
    private lazy var descriptionTextView = CustomTextView.createTextView(placeholder: "Текст")
    private lazy var imagePicker = CustomImagePicker.createImagePicker(delegate: self)
    
    private lazy var imageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        return image
    }()
    
    private lazy var addImageButton = CustomButton.createSmallButton(title: "Добавить фото", action: UIAction(handler: { _ in
        self.present(self.imagePicker, animated: true)
    }))
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 20, arrangedSubviews: [titleTextField,
                                                                                         descriptionTextView,
                                                                                          imageView,
                                                                                         addImageButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateImageViewVisibility()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    private func updateImageViewVisibility() {
        if imageView.image == nil {
            imageView.isHidden = true
        } else {
            imageView.isHidden = false
        }
    }
}

extension NewNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.imageView.image = image
        } else if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        updateImageViewVisibility()
        picker.dismiss(animated: true)
    }
}
