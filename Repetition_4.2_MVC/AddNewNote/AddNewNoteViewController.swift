//
//  AddNewNoteViewController.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 20.02.2023.
//

import UIKit

class AddNewNoteViewController: UIViewController {
    
    private lazy var themeLabel: UILabel = {
        let label = setLabel(
            size: 21,
            text: "Theme")
        return label
    }()
    
    private lazy var themeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your topic"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .next
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = CGColor(
            red: 110/255,
            green: 110/255,
            blue: 110/255,
            alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = setLabel(
            size: 21,
            text: "Description")
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = CGColor(
            red: 110/255,
            green: 110/255,
            blue: 110/255,
            alpha: 1)
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 3,
            bottom: 10,
            right: 3
        )
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    var delegate: NewNoteDelegate!
    var viewModel: AddNewNoteViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(subviews: themeLabel,
                    themeTextField,
                    descriptionLabel,
                    descriptionTextView)
        setConstraints()
        setupDesign()
        newNote()
        settingKeyboard()
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            themeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            themeTextField.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 10),
            themeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            themeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            themeTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: themeTextField.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    private func setupDesign() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor(
            red: 220/255,
            green: 190/255,
            blue: 30/255,
            alpha: 1
        )
    }
    
    private func newNote() {
        let newNote = viewModel.addNewNote()
        delegate.saveNote(note: newNote)
    }
    
    private func settingKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTextView),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTextView),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func updateTextView(value: Notification) {
        viewModel.updateTextView(value: value, textView: descriptionTextView, view: view)
    }
}

extension AddNewNoteViewController {
    private func setLabel(size: CGFloat, text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension AddNewNoteViewController: UITextFieldDelegate, UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionTextView.becomeFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let mainLabel = viewModel.textFromTextField(textField: textField)
        let text = viewModel.textFromTextView(textView: descriptionTextView)
        delegate.addNote(mainLabel: mainLabel, text: text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let mainLabel = viewModel.textFromTextField(textField: themeTextField)
        let text = viewModel.textFromTextView(textView: textView)
        delegate.addNote(mainLabel: mainLabel, text: text)
    }
}
