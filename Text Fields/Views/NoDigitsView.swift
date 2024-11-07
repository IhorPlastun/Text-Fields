//
//  NoDigitsView.swift
//  Text Fields
//
//  Created by Igor Plastun on 06.11.2024.
//

import Foundation
import UIKit

final class NoDigitsView: UIView {
    private let noDigitsLabel: UILabel = {
        var label = UILabel()
        label.text = "NO digits field"
        label.font = .systemFont(ofSize: .init(15))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noDigitsTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Type here"
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(noDigitsLabel)
        addSubview(noDigitsTextField)
        
        NSLayoutConstraint.activate([
            noDigitsLabel.topAnchor.constraint(equalTo: topAnchor),
            noDigitsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            noDigitsTextField.topAnchor.constraint(equalTo: noDigitsLabel.bottomAnchor, constant: 10),
            noDigitsTextField.centerXAnchor.constraint(equalTo:centerXAnchor),
            noDigitsTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
        ])
    }
    
    func getTextField() -> UITextField {
        return noDigitsTextField
    }
    
    func setTextField(str: String) {
        noDigitsTextField.text = str
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}
