//
//  UIView + Extension.swift
//  Text Fields
//
//  Created by Igor Plastun on 06.11.2024.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(subviews: [UIView]) {
        subviews.forEach{ self.addSubview($0) }
    }
    
    func addBackgroundForTextField(subviews: [UIView]) {
        subviews.forEach{ view in
            if view is UITextField {
                addBackground(textField: view)
            } else {
                addBackgroundForTextField(subviews: view.subviews)
            }
        }
    }
    
    private func addBackground(textField: UIView) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 5
        backgroundView.alpha = 0.3
        backgroundView.isUserInteractionEnabled = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(backgroundView, belowSubview: textField)
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalTo: textField.widthAnchor, constant: 18),
            backgroundView.heightAnchor.constraint(equalTo: textField.heightAnchor, constant: 10),
        ])
    }
    
}
