//
//  MaskedView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

final class MaskedView: UIView {
    private let maskedLabel: UILabel = {
        var label = UILabel()
        label.text = "Only characters"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let maskedTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "wwwww-ddddd"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
