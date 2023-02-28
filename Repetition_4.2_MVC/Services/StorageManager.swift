//
//  StorageManager.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 28.02.2023.
//

import Foundation

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefault = UserDefaults.standard
    private let notesKey = "notes"
    
    private init() {}
    
    func saveNote(note: Notebook) {
        var notes = fetchNotes()
        notes.append(note)
        guard let data = try? JSONEncoder().encode(notes) else { return }
        userDefault.set(data, forKey: notesKey)
    }
    
    func deleteNote(note: Int) {
        var notes = fetchNotes()
        notes.remove(at: note)
        guard let data = try? JSONEncoder().encode(notes) else { return }
        userDefault.set(data, forKey: notesKey)
    }
    
    func rewriteNote(notes: [Notebook]) {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        userDefault.set(data, forKey: notesKey)
    }
    
    func fetchNotes() -> [Notebook] {
        guard let data = userDefault.object(forKey: notesKey) as? Data else { return [] }
        guard let notes = try? JSONDecoder().decode([Notebook].self, from: data) else { return [] }
        return notes
    }
}
