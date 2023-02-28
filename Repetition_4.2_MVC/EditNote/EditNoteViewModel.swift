//
//  EditNoteViewModel.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 27.02.2023.
//

import UIKit

protocol EditNoteViewModelProtocol {
    var mainLabel: String { get }
    var text: String { get }
    var index: Int { get }
    init(notebook: Notebook, indexPath: Int)
    func updateTextView(value: Notification, textView: UITextView, view: UIView)
    func textFromTextField(textField: UITextField) -> String
    func textFromTextView(textView: UITextView) -> String
}

class EditNoteViewModel: EditNoteViewModelProtocol {
    var mainLabel: String {
        notebook.mainLabel
    }
    
    var text: String {
        notebook.text
    }
    
    var index: Int {
        indexPath
    }
    
    private let notebook: Notebook
    private let indexPath: Int
    
    required init(notebook: Notebook, indexPath: Int) {
        self.notebook = notebook
        self.indexPath = indexPath
    }
    
    func updateTextView(value: Notification, textView: UITextView, view: UIView) {
        let userInfo = value.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = view.convert(getKeyboardRect, to: view.window)
        
        if value.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardFrame.height,
                right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    func textFromTextField(textField: UITextField) -> String {
        let text = textField.text ?? ""
        return text
    }
    
    func textFromTextView(textView: UITextView) -> String {
        let text = textView.text ?? ""
        return text
    }
}
