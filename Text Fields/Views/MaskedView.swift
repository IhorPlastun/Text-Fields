//
//  MaskedView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class MaskedView: UIView {
    private let manager = TextFieldsManagers()
    
    private let maskedLabel: UILabel = {
        var label = UILabel()
        label.text = "Only characters"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maskedTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "wwwww-ddddd"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
   private func setupUI() {
        addSubview(maskedLabel)
        addSubview(maskedTextField)
       
        NSLayoutConstraint.activate([
            maskedLabel.topAnchor.constraint(equalTo: topAnchor),
            maskedLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            maskedTextField.topAnchor.constraint(equalTo: maskedLabel.bottomAnchor, constant: 10),
            maskedTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            maskedTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
        ])
    }
    
    private func defaultSettings() {
        maskedTextField.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        defaultSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MaskedView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let stringTextField = textField.text else { return true }
        let (shouldChange, updatedText) = manager.maskedTextField(stringTextField: stringTextField, range: range, string: string)
        if string.isEmpty {
            return true
        }
        if shouldChange {
            maskedTextField.text = updatedText
        }
        return false
    }
}
