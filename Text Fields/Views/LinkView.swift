//
//  LinkView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class LinkView: UIView {
    private let linkLabel: UILabel = {
        var label = UILabel()
        label.text = "Link"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let linkTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "www.example.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .go
        return textField
    }()
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(linkLabel)
        addSubview(linkTextField)
        
        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: topAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 10),
            linkTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            linkTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
