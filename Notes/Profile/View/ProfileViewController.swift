//
//  ProfoleViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit
import SDWebImage

protocol ProfileViewProtocol: AnyObject {
    func setUserData(imageUrl: URL?, name: String?, birthday: String?)
    func showError(message: String)
}

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    private lazy var imageView: UIView = UIView()
    
    private lazy var imagePicker = CustomImagePicker.createImagePicker(delegate: self)
    
    private lazy var avatarImage: UIImageView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageAction))
        
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
        image.image = .placeholder
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = (view.frame.width / 2) / 2
        
        image.layer.borderColor = UIColor.white.cgColor // Цвет обводки
        image.layer.borderWidth = 2.0 // Ширина обводки
        
        return image
    }()
    
    private lazy var nameLabel = CustomLabel.createMainLabel(text: "User Name")
    private lazy var emailLabel = CustomLabel.createSubLabel(text: presenter.email ?? "")
    private lazy var                                                                                            birthdayLabel = CustomLabel.createDateLabel(text: "07 апреля 2006")
    
    private lazy var notesButton = CustomButton.profileButton(title: "Заметки", imageName: "folder", action: UIAction(handler: { [weak self] _ in
        let notesVC = NotesListViewController()
        self?.navigationController?.pushViewController(notesVC, animated: true)
    }))
    
    private lazy var settingsButton = CustomButton.profileButton(title: "Настройки", imageName: "gear", action: UIAction(handler: { [weak self] _ in
        self?.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }))
    
    private lazy var exitButton = CustomButton.createBigButton(title: "Выход", action: UIAction(handler: { [weak self] _ in
        self?.presenter.signOut()
    }))
    
    private lazy var labelsStack = CustomVStack.createStack(spacing: 5, arrangedSubviews: [nameLabel,
                                                                                           emailLabel,
                                                                                           birthdayLabel],
                                                            alignment: .center)
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 20, arrangedSubviews: [imageView,
                                                                                          labelsStack,
                                                                                          notesButton,
                                                                                          settingsButton])
    
    private var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My account"
        presenter = ProfilePresenter(view: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getUserData()
    }
    
    @objc func tapImageAction() {
        present(imagePicker, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        
        view.addSubview(mainStack)
        view.addSubview(exitButton)
        
        imageView.addSubview(avatarImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: imageView.topAnchor),
            avatarImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor, multiplier: 1),
            
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func setUserData(imageUrl: URL?, name: String?, birthday: String?) {
        avatarImage.sd_setImage(with: imageUrl, placeholderImage: .placeholder)
        nameLabel.text = name
        birthdayLabel.text = birthday
    }
    
    func showError(message: String) {
        let alert = CustomAlertController.createAlertController(message: message)
        present(alert, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.avatarImage.image = image
            
            if let imageData = image.pngData() {
                presenter.uploadImage(image: imageData)
            } else if let imageData = image.jpegData(compressionQuality: 0.1) {
                presenter.uploadImage(image: imageData)
            }
            
        } else if let image = info[.originalImage] as? UIImage {
            self.avatarImage.image = image
        }
        picker.dismiss(animated: true)
        
    }
}
