//
//  TextEditPresenter.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 21.02.2023.
//

import UIKit

protocol TextEditPresenterProtocol {
    init(view: TextEditViewProtocol)
    func createNotebook()
}

protocol TextFieldPresenterProtocol {
    init(view: TextFieldViewProtocol, textField: UITextField)
    func rewriteNote()
}

protocol TextViewPresenterProtocol {
    init(view: TextViewViewProtocol, textView: UITextView)
    func rewriteNote()
}

class TextEditPresenter: TextEditPresenterProtocol {
    unowned let view: TextEditViewProtocol
    
    required init(view: TextEditViewProtocol) {
        self.view = view
    }
    
    func createNotebook() {
        let newNote = Notebook(
            mainLabel: "",
            secondLabel: "",
            text: "")
        view.saveNote(note: newNote)
    }
}

class TextFieldPresenter: TextFieldPresenterProtocol {
    unowned let view: TextFieldViewProtocol
    let textField: UITextField
    
    required init(view: TextFieldViewProtocol, textField: UITextField) {
        self.view = view
        self.textField = textField
    }
    
    func rewriteNote() {
        let text = textField.text ?? ""
        view.rewriteNoteTextField(note: text)
    }
}

class TextViewPresenter: TextViewPresenterProtocol {
    unowned let view: TextViewViewProtocol
    let textView: UITextView
    
    required init(view: TextViewViewProtocol, textView: UITextView) {
        self.view = view
        self.textView = textView
    }
    
    func rewriteNote() {
        let text = textView.text ?? ""
        view.rewriteNoteTextView(note: text)
    }
}
