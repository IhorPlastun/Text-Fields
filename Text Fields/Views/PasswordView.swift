//
//  PasswordLabel.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class PasswordView: UIView {
    private let passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Validation rules"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     let rulesLengthCharLabel: UILabel = {
        var label = UILabel()
        label.text = "Min length 8 characters."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let rulesCountNumLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 digit."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let rulesLowercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 lowercase."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let rulesUppercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 uppercase."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(rulesLengthCharLabel)
        addSubview(rulesCountNumLabel)
        addSubview(rulesLowercaseLabel)
        addSubview(rulesUppercaseLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: topAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo:centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo:widthAnchor, constant: -16),
            
            rulesLengthCharLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            rulesLengthCharLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            rulesCountNumLabel.topAnchor.constraint(equalTo: rulesLengthCharLabel.bottomAnchor, constant: 10),
            rulesCountNumLabel.leadingAnchor.constraint(equalTo:leadingAnchor),
            
            rulesLowercaseLabel.topAnchor.constraint(equalTo: rulesCountNumLabel.bottomAnchor, constant: 10),
            rulesLowercaseLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            rulesUppercaseLabel.topAnchor.constraint(equalTo: rulesLowercaseLabel.bottomAnchor, constant: 10),
            rulesUppercaseLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rulesUppercaseLabel.bottomAnchor.constraint(equalTo:bottomAnchor)
        ])
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

