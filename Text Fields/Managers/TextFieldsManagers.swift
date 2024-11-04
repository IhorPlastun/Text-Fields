//
//  TextFieldsManagers.swift
//  Text Fields
//
//  Created by Igor Plastun on 30.10.2024.
//

import Foundation
import UIKit

final class TextFieldsManagers {
    func openUrl(strURL: String) -> UIAlertController? {
        var alert: UIAlertController?
        var urlString = strURL
        if !urlString.lowercased().hasPrefix("http://") && !urlString.lowercased().hasPrefix("https://") {
            urlString = "https://\(urlString)"
        }
        
        if let url = URL(string: urlString), let host = url.host, url.scheme != nil {
            UIApplication.shared.open(url)
        } else {
            alert = UIAlertController(title: "Ошибка", message: "Некорректный адрес", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert?.addAction(action)
        }
        return alert
    }
    
    func validPasswordRules(textField: UITextField, range: NSRange, string: String, labels: [UILabel]) -> Bool {
        if string.contains(" ") {
            return false
        }
        
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
        if !string.allSatisfy({ $0.isLetter || $0.isNumber }) {
            return false
        }
        guard let textRange = Range(range, in: currentText) else { return false }
        var updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        if updatedText.count > 11 {
            return false
        }
        if updatedText.count <= 5 {
            if !string.allSatisfy({ $0.isLetter }) {
                return false
            }
        }
        if currentText.count == 5 && !currentText.contains("-") {
            if string.allSatisfy({ $0.isLetter }) {
                return false
            }
        }
        if updatedText.count == 6 && !updatedText.contains("-") {
            updatedText.insert("-", at: updatedText.index(updatedText.startIndex, offsetBy: 5))
            textField.text = updatedText
            return false
        }
        if updatedText.count > 6 {
            if string.contains(where: { $0.isLetter }) {
                return false
            }
            if !string.allSatisfy({ $0.isNumber }) {
                return false
            }
        }
        return true
    }
    
    
    
    func noNumberInString(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return true}
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        if updatedText.allSatisfy({ !$0.isNumber }){
            return true
        } else {
            return false
        }
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
