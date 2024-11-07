//
//  inputLimitView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class InputLimitView: UIView {
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
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
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
    
    func getTextField() -> UITextField {
        return inputLimitTextField
    }
    
    func updateCharCount(count: Int) {
        countCharLabel.text = "\(count)/10"
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
