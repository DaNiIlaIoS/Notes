//
//  ProfoleViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
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
        return image
    }()
    
    private lazy var nameLabel = CustomLabel.createMainLabel(text: "User Name")
    private lazy var emailLabel = CustomLabel.createSubLabel(text: "sivozelezovdaniil@gmail.com")
    private lazy var birthsdayLabel = CustomLabel.createDateLabel(text: "07 апреля 2006")
    
    private lazy var buttonRightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var notesButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 20
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17)
            return outgoing
        })
        
        let button = UIButton(configuration: config, primaryAction: UIAction(handler: { [weak self] _ in
            let notesVC = NotesViewController()
            self?.navigationController?.pushViewController(notesVC, animated: true)
        }))
        
        button.setTitle("Заметки", for: .normal)
        button.setImage(UIImage(systemName: "folder"), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray6
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addSubview(buttonRightImage)
        return button
    }()
    
    private lazy var exitButton = CustomButton.createBigButton(title: "Выход", action: UIAction(handler: { [weak self] _ in
        self?.presenter.signOut()
    }))
    
    private lazy var labelsStack = CustomVStack.createStack(spacing: 5, arrangedSubviews: [nameLabel,
                                                                                           emailLabel,
                                                                                           birthsdayLabel],
                                                            alignment: .center)
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 20, arrangedSubviews: [imageView,
                                                                                          labelsStack,
                                                                                          notesButton])
    
    private var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My account"
        presenter = ProfilePresenter(view: self)
        setupUI()
    }
    
    @objc func tapImageAction() {
        present(imagePicker, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
            
            buttonRightImage.trailingAnchor.constraint(equalTo: notesButton.trailingAnchor, constant: -10),
            buttonRightImage.centerYAnchor.constraint(equalTo: notesButton.centerYAnchor),
        ])
    }
    
    func showError(message: String) {
        //
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.avatarImage.image = image
        } else if let image = info[.originalImage] as? UIImage {
            self.avatarImage.image = image
        }
        picker.dismiss(animated: true)
        
    }
}
