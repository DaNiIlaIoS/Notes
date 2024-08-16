//
//  CustomButton.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 04.08.2024.
//

import UIKit

struct CustomButton {
    static func createBigButton(title: String, action: UIAction? = nil) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    static func createShowPasswordButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        return button
    }
    
    static func createSmallButton(title: String, action: UIAction? = nil) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func profileButton(title: String, imageName: String, action: UIAction) -> UIButton {
            var buttonRightImage: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "chevron.right")
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            
            var config = UIButton.Configuration.plain()
            config.imagePlacement = .leading
            config.imagePadding = 20
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 17)
                return outgoing
            })
            
            let button = UIButton(configuration: config, primaryAction: action)
            
            button.setTitle(title, for: .normal)
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.contentHorizontalAlignment = .leading
            button.layer.cornerRadius = 10
            button.backgroundColor = .white
            button.tintColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addSubview(buttonRightImage)
            
            NSLayoutConstraint.activate([
                buttonRightImage.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
                buttonRightImage.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            ])
            
            return button
    }
}

