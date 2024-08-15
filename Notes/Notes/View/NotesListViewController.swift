//
//  NotesViewController.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 05.08.2024.
//

import UIKit

protocol NoteListViewProtocol: AnyObject {
    func updateNotes()
}

final class NotesListViewController: UIViewController, NoteListViewProtocol {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.background
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseId)
        return tableView
    }()
    
    private var presenter: NoteListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NoteListPresenter(view: self)
        setupUI()
    }
    
    private func setupUI() {
        title = "Заметки"
        view.backgroundColor = UIColor.background
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNote))
    }
    
    func updateNotes() {
        tableView.reloadData()
    }
    
    @objc func createNote() {
        let noteVC = NoteViewController()
        navigationController?.pushViewController(noteVC, animated: true)
    }
}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseId, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = presenter.notes[indexPath.row]
        
        cell.configCell(note: note)
        
        return cell
    }
}

extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let note = notes[indexPath.row]
        let noteVC = NoteViewController()
        navigationController?.pushViewController(noteVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = presenter.notes[indexPath.row]
            presenter.deleteNote(noteId: note.id)
            presenter.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
