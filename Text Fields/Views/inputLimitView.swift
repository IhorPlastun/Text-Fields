//
//  inputLimitView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class InputLimitView: UIView {
    private let manager = TextFieldsManagers()
    
    private let inputLimitLabel: UILabel = {
        var label = UILabel()
        label.text = "Input limit"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countCharLabel: UILabel = {
        var label = UILabel()
        label.text = "0/10"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let inputLimitTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Type here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
  private func setupUI() {
        addSubview(inputLimitLabel)
        addSubview(countCharLabel)
        addSubview(inputLimitTextField)
        
        NSLayoutConstraint.activate([
            inputLimitLabel.topAnchor.constraint(equalTo: topAnchor),
            inputLimitLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            countCharLabel.topAnchor.constraint(equalTo: topAnchor),
            countCharLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            inputLimitTextField.topAnchor.constraint(equalTo: inputLimitLabel.bottomAnchor, constant: 10),
            inputLimitTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputLimitTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
        ])
    }
    
    private func defaultSettings() {
        inputLimitTextField.delegate = self
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

extension InputLimitView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let stringTextField = textField.text {
            let (shouldChange, countChar) = manager.limitCharInString(stringTextField: stringTextField, range: range, string: string)
            if shouldChange {
                countCharLabel.text = "\(countChar)/10"
                return true
            }
            return false
        }
        return true
    }
}
