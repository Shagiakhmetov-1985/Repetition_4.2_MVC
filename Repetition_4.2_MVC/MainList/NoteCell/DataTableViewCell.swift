//
//  DataTableViewCell.swift
//  Repetition_4.2_MVC
//
//  Created by Marat Shagiakhmetov on 20.02.2023.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    let mainLabel = UILabel()
    let secondLabel = UILabel()
    
    var viewModel: DataCellViewModelProtocol! {
        didSet {
            mainLabel.text = viewModel.mainLabel
            secondLabel.text = viewModel.secondLabel
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainLabel.font = UIFont.systemFont(ofSize: 17)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondLabel.font = UIFont.systemFont(ofSize: 17)
        secondLabel.layer.opacity = 0.4
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(subviews: mainLabel, secondLabel)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 0),
            secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5)
        ])
    }
}
