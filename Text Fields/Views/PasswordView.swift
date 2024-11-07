//
//  PasswordLabel.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class PasswordView: UIView {
    private let manager = TextFieldsManagers()
    
    private let passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Validation rules"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let rulesLengthCharLabel: UILabel = {
        var label = UILabel()
        label.text = "Min length 8 characters."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesCountNumLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 digit."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesLowercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 lowercase."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesUppercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 uppercase."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private func setupUI() {
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
    
    private func defaultSettings() {
        passwordTextField.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
        defaultSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let stringTextField = textField.text else { return true }
        if string.contains(" ") {
            return false
        }
        let result = manager.validPasswordRules(stringTextField: stringTextField, range: range, string: string)
        rulesLengthCharLabel.textColor = result["minLengthRequirement"] == true ? .green : .red
        rulesCountNumLabel.textColor = result["containsNumber"] == true ? .green : .red
        rulesLowercaseLabel.textColor = result["containsLowercase"] == true ? .green : .red
        rulesUppercaseLabel.textColor = result["containsUppercase"] == true ? .green : .red
        return true
    }
}


