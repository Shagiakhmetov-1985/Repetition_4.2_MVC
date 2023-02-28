//
//  MainViewController.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 19.02.2023.
//

import UIKit

protocol NewNoteDelegate {
    func saveNote(note: Notebook)
    func addNote(mainLabel: String, text: String)
    func rewriteNote(mainLabel: String, text: String, index: Int)
}

class MainViewController: UITableViewController {
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchNotes {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupBarButtonAndTitle()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupBarButtonAndTitle() {
        let barButton = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(addNewNote))
        barButton.tintColor = UIColor(
            red: 220/255,
            green: 190/255,
            blue: 30/255,
            alpha: 1)
        
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    @objc private func addNewNote() {
        let addNewNoteVC = AddNewNoteViewController()
        addNewNoteVC.delegate = self
        addNewNoteVC.viewModel = AddNewNoteViewModel()
        show(addNewNoteVC, sender: self)
    }
}

extension MainViewController: NewNoteDelegate {
    func saveNote(note: Notebook) {
        viewModel.saveNote(note: note)
        tableView.reloadData()
    }
    
    func addNote(mainLabel: String, text: String) {
        viewModel.addNote(mainLabel: mainLabel, text: text)
        tableView.reloadData()
    }
    
    func rewriteNote(mainLabel: String, text: String, index: Int) {
        viewModel.rewriteNote(mainLabel: mainLabel, text: text, index: index)
        tableView.reloadData()
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
        return cell
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteNote(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textVC = EditNoteViewController()
        textVC.delegate = self
        textVC.viewModel = viewModel.editNoteViewModel(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        show(textVC, sender: self)
    }
}
