//
//  OnboardingCell.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 22.08.2024.
//

import UIKit
import Lottie

final class OnboardingCell: UICollectionViewCell {
    static let reuseId = "OnboardingCell"
    
    private lazy var titleLabel = CustomLabel.createMainLabel(text: "")
    private lazy var textLabel = CustomLabel.createSubLabel(alignment: .center)
    
    private lazy var lottieView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(item: OnboardingModel) {
        titleLabel.text = item.title
        textLabel.text = item.text
        lottieView.animation = LottieAnimation.named(item.animationName)
        lottieView.play()
    }
    
    private func setupCell() {
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(lottieView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            lottieView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lottieView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lottieView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
