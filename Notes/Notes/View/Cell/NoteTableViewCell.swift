//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit
import SDWebImage

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
        let label = CustomLabel.createSubLabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var dateLabel = CustomLabel.createDateLabel()
    private lazy var descriptionLabel = CustomLabel.createSubLabel()
    
    lazy var noteImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: self.frame.width / 2).isActive = true
        return image
    }()
    
    private lazy var titleStack = CustomVStack.createStack(spacing: 5, arrangedSubviews: [titleLabel,
                                                                                          dateLabel,])
    
    private lazy var mainStack = CustomVStack.createStack(spacing: 10, arrangedSubviews: [titleStack,
                                                                                          noteImage,
                                                                                          descriptionLabel])
    
    var isCompleted: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(note: Note) {
        titleLabel.text = note.title
        dateLabel.text = Date().formateDate(dateString: note.id)
        descriptionLabel.text = note.description
        isCompleted = note.isCompleted
        
        if let image = note.imageUrl {
            noteImage.isHidden = false
            noteImage.sd_setImage(with: image)
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

