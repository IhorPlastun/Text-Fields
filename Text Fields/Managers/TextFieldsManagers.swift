//
//  TextFieldsManagers.swift
//  Text Fields
//
//  Created by Igor Plastun on 30.10.2024.
//

import Foundation
import UIKit

final class TextFieldsManagers {
    func openUrl(url: URL) -> UIAlertController? {
        var alert: UIAlertController?
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            alert = UIAlertController(title: "Ошибка", message: "Не коректный адрес", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert?.addAction(action)
        }
        return alert
    }
    
    func validPasswordRules(textField: UITextField, range: NSRange, string: String, labels: [UILabel]) -> Bool {
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return true }
        let str = currentText.replacingCharacters(in: textRange, with: string)
        let containsLowercase = str.contains(where: \.isLowercase)
        let containsUppercase = str.contains(where: \.isUppercase)
        let containsNumber = str.contains(where: \.isNumber)
        let meetsLengthRequirement = str.count >= 8
        
        for label in labels {
            switch label.text {
            case "Minimum 1 lowercase.":
                label.textColor = containsLowercase ? .systemGreen : .systemRed
            case "Minimum 1 uppercase.":
                label.textColor = containsUppercase ? .systemGreen : .systemRed
            case "Minimum 1 digit.":
                label.textColor = containsNumber ? .systemGreen : .systemRed
            case "Min length 8 characters.":
                label.textColor = meetsLengthRequirement ? .systemGreen : .systemRed
            default:
                break
            }
        }
        return true
    }
    
    func maskedTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        if string.isEmpty {
            return true
        }
        
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        if updatedText.count > 11 {
            return false
        }
        
        if updatedText.count <= 5 {
            if !string.isEmpty && !string.allSatisfy({ $0.isLetter }) {
                return false
            }
        }
        
        if updatedText.count == 5 && !updatedText.contains("-") {
            textField.text = updatedText + "-"
            return false
        }
        
        if updatedText.count > 6 {
            if !string.isEmpty && !string.allSatisfy({ $0.isNumber }) {
                return false
            }
        }
        return true
    }
    
    func noNumberInString(string: String) -> String {
        var characters = Array(string)
        if characters.contains(where: \.isNumber) {
            characters.removeAll(where: \.isNumber)
        }
        return String(characters)
    }
    
    func limitCharInString(textField: UITextField, range: NSRange, string: String, label: UILabel) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return true }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        if updatedText.count <= 10{
            label.text = "\(updatedText.count)/10"
            return true
        } else {
            return false
        }
    }
}
