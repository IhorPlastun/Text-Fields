//
//  LinkView.swift
//  Text Fields
//
//  Created by Igor Plastun on 07.11.2024.
//

import Foundation
import UIKit

protocol LinkViewDelegate: AnyObject {
    func showAlert()
}

final class LinkView: UIView {
    weak var delegate: LinkViewDelegate?
    private let manager = TextFieldsManagers()
    
    private let linkLabel: UILabel = {
        var label = UILabel()
        label.text = "Link"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "www.example.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .go
        return textField
    }()
    
   private func setupUI() {
      
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
    
    private func defaultSettings() {
        linkTextField.delegate = self
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

extension LinkView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == linkTextField {
            guard let strURL = textField.text else { return true }
            let (shouldOpen, url) = manager.openUrl(strURL: strURL)
            if shouldOpen {
                if let url = url {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                delegate?.showAlert()
            }
        }
        return true
    }
}
