//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

final class NoteViewController: UIViewController {
    
    private lazy var titleTextField = CustomTextField.createTextField(placeholder: "Заголовок")
    private lazy var descriptionTextView = CustomTextView.createTextView(placeholder: "Текст")
    private lazy var imagePicker = CustomImagePicker.createImagePicker(delegate: self)
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var addImageButton = CustomButton.createSmallButton(title: "Добавить фото", action: UIAction(handler: { _ in
        self.present(self.imagePicker, animated: true)
    }))
    
    private lazy var saveButton = CustomButton.createBigButton(title: "Сохранить", action: UIAction(handler: { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
    }))
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 20, arrangedSubviews: [titleTextField,
                                                                                          descriptionTextView,
                                                                                          imageView,
                                                                                          addImageButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateImageViewVisibility()
        
        descriptionTextView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        view.addSubview(mainStack)
        view.addSubview(saveButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func set(note: Note) {
        titleTextField.text = note.title
        
        descriptionTextView.text = note.description
        descriptionTextView.textColor = .textViewText
        
        if let image = note.image {
            imageView.image = UIImage(named: image)
        }
        
    }
    
    private func updateImageViewVisibility() {
        if imageView.image == nil {
            imageView.isHidden = true
        } else {
            imageView.isHidden = false
        }
    }
}

extension NoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray3 {
            textView.text = nil
            textView.textColor = .textViewText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Текст"
            textView.textColor = UIColor.lightGray
        }
    }
}
