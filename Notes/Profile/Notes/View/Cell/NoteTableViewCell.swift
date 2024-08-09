//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    static let reuseId = "NoteTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CustomLabel.createSubLabel(text: "Заголовок заметки")
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var dateLabel = CustomLabel.createDateLabel(text: "25.04.24")
    private lazy var descriptionLabel = CustomLabel.createSubLabel(text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore")
    
    lazy var noteImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.image = .placeholder
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: self.frame.width / 2).isActive = true
        return image
    }()
    
    private lazy var titleStack = CustomVStack.createStack(spacing: 5, arrangedSubviews: [titleLabel,
                                                                                          dateLabel,])
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 10, arrangedSubviews: [titleStack,
                                                                                          noteImage,
                                                                                          descriptionLabel])
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(note: Note) {
        titleLabel.text = note.title
        dateLabel.text = note.date
        descriptionLabel.text = note.description
        
        if let image = note.image {
            noteImage.image = UIImage(named: image)
            noteImage.isHidden = false
        } else {
            noteImage.isHidden = true
        }
    }
    
    private func setupUI() {
        addSubview(cellView)
        contentView.removeFromSuperview()
        backgroundColor = UIColor.background
        cellView.addSubview(mainStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            mainStack.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15),
        ])
    }
}
