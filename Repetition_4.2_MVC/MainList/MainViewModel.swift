//
//  MainViewModel.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 27.02.2023.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var notebook: [Notebook] { get }
    func fetchNotes(completion: @escaping() -> Void)
    func deleteNote(indexPath: IndexPath)
    func saveNote(note: Notebook)
    func addNote(mainLabel: String, text: String)
    func rewriteNote(mainLabel: String, text: String, index: Int)
    func numberOfRows() -> Int
    func cellViewModel(indexPath: IndexPath) -> DataCellViewModelProtocol
    func editNoteViewModel(indexPath: IndexPath) -> EditNoteViewModelProtocol
}

class MainViewModel: MainViewModelProtocol {
    var notebook: [Notebook] = []
    
    func fetchNotes(completion: @escaping () -> Void) {
        notebook = StorageManager.shared.fetchNotes()
        completion()
    }
    
    func deleteNote(indexPath: IndexPath) {
        notebook.remove(at: indexPath.row)
        StorageManager.shared.deleteNote(note: indexPath.row)
    }
    
    func saveNote(note: Notebook) {
        notebook.append(note)
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
        
        StorageManager.shared.rewriteNote(notes: notebook)
    }
    
    func rewriteNote(mainLabel: String, text: String, index: Int) {
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.YYYY в HH:mm"
        
        notebook[index].mainLabel = mainLabel
        notebook[index].secondLabel = formatter.string(from: currentDate)
        notebook[index].text = text
        
        StorageManager.shared.rewriteNote(notes: notebook)
    }
    
    func numberOfRows() -> Int {
        notebook.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> DataCellViewModelProtocol {
        let note = notebook[indexPath.row]
        return DataCellViewModel(notebook: note)
    }
    
    func editNoteViewModel(indexPath: IndexPath) -> EditNoteViewModelProtocol {
        let note = notebook[indexPath.row]
        return EditNoteViewModel(notebook: note, indexPath: indexPath.row)
    }
}
