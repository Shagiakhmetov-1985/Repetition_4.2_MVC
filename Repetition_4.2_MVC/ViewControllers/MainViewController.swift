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
    
    private var notebook: [Notebook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notebook.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        let data = notebook[indexPath.row]
        
        cell.mainLabel.text = data.mainLabel
        cell.secondLabel.text = data.secondLabel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notebook.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteNote(note: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textVC = TextViewController()
        textVC.delegate = self
        textVC.notebook = notebook[indexPath.row]
        textVC.index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        show(textVC, sender: self)
    }
    
    private func setup() {
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
        
        tableView.rowHeight = 50
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        notebook = StorageManager.shared.fetchNotes()
    }
    
    @objc private func addNewNote() {
        let textEditVC = TextEditViewController()
        textEditVC.delegate = self
        show(textEditVC, sender: self)
    }
}

extension MainViewController: NewNoteDelegate {
    func saveNote(note: Notebook) {
        notebook.append(note)
        tableView.reloadData()
        StorageManager.shared.saveNote(note: note)
    }
    
    func addNote(mainLabel: String, text: String) {
        let count = notebook.count - 1
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.YYYY в HH:mm"
        
        notebook[count].mainLabel = mainLabel
        notebook[count].secondLabel = formatter.string(from: currentDate)
        notebook[count].text = text
        
        tableView.reloadData()
        StorageManager.shared.rewriteNote(notes: notebook)
    }
    
    func rewriteNote(mainLabel: String, text: String, index: Int) {
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.YYYY в HH:mm"
        
        notebook[index].mainLabel = mainLabel
        notebook[index].secondLabel = formatter.string(from: currentDate)
        notebook[index].text = text
        
        tableView.reloadData()
        StorageManager.shared.rewriteNote(notes: notebook)
    }
}
