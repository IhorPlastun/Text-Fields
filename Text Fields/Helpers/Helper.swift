//
//  Helper.swift
//  Text Fields
//
//  Created by Igor Plastun on 29.10.2024.
//

import Foundation
import UIKit

final class Helper{
    static let shared = Helper()
    private init(){}
    
    func addSubviews(subviews: [UIView], view: UIView){
        subviews.forEach{ view.addSubview($0) }
    }
    
    func addBackgroundForTextField(subviews: [UIView], parentView: UIView){
        subviews.forEach{ if $0 is UITextField{
            let backgroundView = UIView()
            backgroundView.backgroundColor = .lightGray
            backgroundView.layer.cornerRadius = 5
            backgroundView.alpha = 0.3
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            parentView.insertSubview(backgroundView, belowSubview: $0)
            
            NSLayoutConstraint.activate([
                backgroundView.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
                backgroundView.centerYAnchor.constraint(equalTo: $0.centerYAnchor),
                backgroundView.widthAnchor.constraint(equalTo: $0.widthAnchor, constant: 18),
                backgroundView.heightAnchor.constraint(equalTo: $0.heightAnchor, constant: 10),
            ])
        }}
        
    }
}
