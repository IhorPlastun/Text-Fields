//
//  TextFieldsManagers.swift
//  Text Fields
//
//  Created by Igor Plastun on 30.10.2024.
//

import Foundation


final class TextFieldsManagers {
    static let shared = TextFieldsManagers()
    private init(){}
    
    func openUrl(strURL: String) -> (Bool, URL?) {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: strURL, options: [], range: NSRange(location: 0, length: strURL.utf16.count))
            if matches.isEmpty{
                return (false,nil)
            } else {
                guard let link = matches.first?.url else { return (false, nil) }
                return (true, link)
            }
        } catch {
            print("Ошибка \(error.localizedDescription)")
        }
        return (true, nil)
    }
    
    func validPasswordRules(stringTextField: String, range: NSRange, string: String) -> [String: Bool] {
        var rules: [String: Bool] = ["containsLowercase": false, "containsUppercase": false, "containsNumber": false, "minLengthRequirement":false]
        
        guard let textRange = Range(range, in: stringTextField) else { return rules }
        let str = stringTextField.replacingCharacters(in: textRange, with: string)
        
        rules["containsLowercase"] = str.contains(where: \.isLowercase)
        rules["containsUppercase"] = str.contains(where: \.isUppercase)
        rules["containsNumber"] = str.contains(where: \.isNumber)
        rules["minLengthRequirement"] = str.count >= 8
        return rules
    }
    
    func maskedTextField(stringTextField: String, range: NSRange, string: String) -> (Bool, String) {
        if string.isEmpty {
            if range.location == 5 && stringTextField[Range(range, in: stringTextField)!] == "-" {
                return (false, stringTextField)
            }
            return (true, stringTextField)
        }
        if !string.allSatisfy({ $0.isLetter || $0.isNumber }) {
            return (false, stringTextField)
        }
        guard let textRange = Range(range, in: stringTextField) else { return (false, stringTextField) }
        var updatedText = stringTextField.replacingCharacters(in: textRange, with: string)
        if updatedText.count > 11 {
            return (false, stringTextField)
        }
        if updatedText.count <= 5 {
            if !string.allSatisfy({ $0.isLetter }) {
                return (false, stringTextField)
            }
        }
        if updatedText.count == 6 && !updatedText.contains("-") {
            updatedText.insert("-", at: updatedText.index(updatedText.startIndex, offsetBy: 5))
        }
        if updatedText.count > 6 {
            let postDashText = updatedText.suffix(from: updatedText.index(updatedText.startIndex, offsetBy: 6))
            if !postDashText.allSatisfy({ $0.isNumber }) {
                return (false, stringTextField)
            }
        }
        if updatedText.count > 5 && updatedText[updatedText.index(updatedText.startIndex, offsetBy: 5)] != "-" {
            return (false, stringTextField)
        }
        return (true, updatedText)
    }
    
    
    
    func noNumberInString(stringTextField: String, range: NSRange, string: String) -> (Bool, String) {
        guard let textRange = Range(range, in: stringTextField) else { return (true, stringTextField) }
        let updatedText = stringTextField.replacingCharacters(in: textRange, with: string)
        if updatedText.allSatisfy({ !$0.isNumber }){
            return (true, updatedText)
        } else {
            return (false, updatedText)
        }
    }
    
    func limitCharInString(stringTextField: String, range: NSRange, string: String) -> (Bool, Int) {
        guard let textRange = Range(range, in: stringTextField) else { return (true, stringTextField.count) }
        let updatedText = stringTextField.replacingCharacters(in: textRange, with: string)
        if updatedText.count <= 10{
            return (true, updatedText.count)
        } else {
            return (false, updatedText.count)
        }
    }
}
