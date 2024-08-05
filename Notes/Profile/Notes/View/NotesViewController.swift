//
//  NotesViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

final class NotesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseId)
        return tableView
    }()
    
    private let notes: [Note] = Note.mockObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Заметки"
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNote))
    }
    
    @objc func createNote() {
        let newNoteVC = NewNoteViewController()
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseId, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        let note = notes[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configCell(note: note)
        
        return cell
    }
}
