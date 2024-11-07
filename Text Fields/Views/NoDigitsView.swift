//
//  NoDigitsView.swift
//  Text Fields
//
//  Created by Igor Plastun on 06.11.2024.
//

import Foundation
import UIKit

final class NoDigitsView: UIView {
    private let manager = TextFieldsManagers()
    
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
    
  private func setupUI() {
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
    
    private func defaultSettings() {
        noDigitsTextField.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        defaultSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        defaultSettings()
    }
}

extension NoDigitsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let stringTextField = textField.text {
            let (shouldChange, updatedText) = manager.noNumberInString(stringTextField: stringTextField, range: range, string: string)
            if shouldChange {
                noDigitsTextField.text = updatedText
            }
            return false
        }
        return true
    }
}
