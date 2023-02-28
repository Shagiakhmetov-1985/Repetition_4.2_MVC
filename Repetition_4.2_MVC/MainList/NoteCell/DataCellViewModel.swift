//
//  DataCellViewModel.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 27.02.2023.
//

import Foundation

protocol DataCellViewModelProtocol {
    var mainLabel: String { get }
    var secondLabel: String { get }
    init(notebook: Notebook)
}

class DataCellViewModel: DataCellViewModelProtocol {
    private let notebook: Notebook
    
    var mainLabel: String {
        notebook.mainLabel
    }
    
    var secondLabel: String {
        notebook.secondLabel
    }
    
    required init(notebook: Notebook) {
        self.notebook = notebook
    }
}
