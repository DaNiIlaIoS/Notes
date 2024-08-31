//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit
import SDWebImage

protocol NoteViewProtocol: AnyObject {
    func showError(message: String)
}

final class NoteViewController: UIViewController, NoteViewProtocol {
    
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
    
    private lazy var saveButton = CustomButton.createBigButton(title: "Сохранить", action: saveAction)
    private lazy var updateButton = CustomButton.createBigButton(title: "Обновить", action: updateAction)
    
    private lazy var mainStack = CustomStack.createVStack(spacing: 20, arrangedSubviews: [titleTextField,
                                                                                          descriptionTextView,
                                                                                          imageView,
                                                                                          addImageButton])
    private lazy var saveAction = UIAction { [weak self] _ in
        
        guard let title = self?.titleTextField.text else {
            self?.showError(message: "Please fill title text field")
            return
        }
        
        let imageData = self?.imageView.image?.jpegData(compressionQuality: 0.1)
        
        self?.presenter.createNote(title: title, text: self?.descriptionTextView.text ?? "", image: imageData)
        self?.navigationController?.popViewController(animated: true)
    }
    
    private lazy var updateAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        guard let title = titleTextField.text,
              let description = descriptionTextView.text,
              let note = presenter.note else {
            showError(message: "Please fill title text field")
            return
        }
        
        let imageData = imageView.image?.jpegData(compressionQuality: 0.1)
        
        presenter.updateNote(noteId: note.id, title: title, description: description, imageData: imageData)
        navigationController?.popViewController(animated: true)
    }
    
    var presenter: NotePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        presenter = NotePresenter(view: self)
        
        setupUI()
        updateImageViewVisibility()
        configureUIForNote()
        
        descriptionTextView.delegate = self
    }
    
    private func configureUIForNote() {
        if let note = presenter.note {
            // Если заметка существует, заполняем UI данными
            titleTextField.text = note.title
            
            descriptionTextView.text = note.description
            descriptionTextView.textColor = .textViewText
            
            if let image = note.imageUrl {
                imageView.sd_setImage(with: image)
                updateImageViewVisibility()
            }
            
            saveButton.isHidden = true
            updateButton.isHidden = false
        } else {
            // Если это новая заметка
            saveButton.isHidden = false
            updateButton.isHidden = true
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        view.addSubview(mainStack)
        view.addSubview(saveButton)
        view.addSubview(updateButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        titleTextField.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let button = presenter.note == nil ? saveButton : updateButton
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showError(message: String) {
        let alert = CustomAlertController.createAlertController(message: message)
        present(alert, animated: true)
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
            
            //            if let imageData = image.pngData() {
            //                presenter.uploadImage(image: imageData)
            //            }
            //            if let imageData = image.jpegData(compressionQuality: 0.1) {
            //                presenter.uploadImage(image: imageData)
            //            }
            
        }
        updateImageViewVisibility()
        picker.dismiss(animated: true)
    }
}

extension NoteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if titleTextField.isFirstResponder {
            descriptionTextView.becomeFirstResponder()
        }
        return true
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
