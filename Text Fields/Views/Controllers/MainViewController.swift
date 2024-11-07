//
//  ViewController.swift
//  Text Fields
//
//  Created by Igor Plastun on 29.10.2024.
//

import UIKit

final class MainViewController: UIViewController {
    private let manager = TextFieldsManagers()
    private let noDigitsView = NoDigitsView()
    private let inputLimitView = InputLimitView()
    private let maskedView = MaskedView()
    private let linkView = LinkView()
    private let passwordView = PasswordView()
    
    //MARK: ui elements
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Text Fields"
        label.font = .systemFont(ofSize: .init(30))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView:UIView = {
        let keyboardView = UIView()
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        return keyboardView
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addDefaultConfiguration()
        addObservers()
        addGestureRecognizers()
    }
    
    private func addDefaultConfiguration() {
        let noDigitsTextField = noDigitsView.getTextField()
        noDigitsTextField.delegate = self
        let inputLimitTextField = inputLimitView.getTextField()
        inputLimitTextField.delegate = self
        let maskedTextField = maskedView.getTextField()
        maskedTextField.delegate = self
        let linkTextField = linkView.getTextField()
        linkTextField.delegate = self
        let passwordTextField = passwordView.getTextField()
        passwordTextField.delegate = self
    }
    
    // MARK: serup UI
    private func setUpUI() {
        let arrViews = [ titleLabel,noDigitsView, inputLimitView, maskedView, linkView, passwordView ]
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.view.addSubviews(subviews: arrViews)
        self.view.addBackgroundForTextField(subviews: arrViews)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            noDigitsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            noDigitsView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16),
            noDigitsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            noDigitsView.heightAnchor.constraint(equalToConstant: 50),
            
            inputLimitView.topAnchor.constraint(equalTo: noDigitsView.bottomAnchor, constant: 40),
            inputLimitView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16),
            inputLimitView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            inputLimitView.heightAnchor.constraint(equalToConstant: 50),
            
            maskedView.topAnchor.constraint(equalTo: inputLimitView.bottomAnchor, constant: 40),
            maskedView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16),
            maskedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            maskedView.heightAnchor.constraint(equalToConstant: 50),
            
            linkView.topAnchor.constraint(equalTo: maskedView.bottomAnchor, constant: 40),
            linkView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16),
            linkView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            linkView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordView.topAnchor.constraint(equalTo: linkView.bottomAnchor, constant: 40),
            passwordView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16),
            passwordView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            passwordView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150)
        ])
    }
}
// MARK: TextField delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == linkView.getTextField() {
            guard let strURL = textField.text else { return true }
            let (shouldOpen, url) = manager.openUrl(strURL: strURL)
            if shouldOpen {
                if let url = url {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Некорректный адрес", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordView.getTextField() {
            guard let stringTextField = textField.text else { return true }
            if string.contains(" ") {
                return false
            }
            let result = manager.validPasswordRules(stringTextField: stringTextField, range: range, string: string)
            passwordView.updateValidationStatus(result: result)
        }
        
        if textField == maskedView.getTextField() {
            guard let stringTextField = textField.text else { return true }
            let (shouldChange, updatedText) = manager.maskedTextField(stringTextField: stringTextField, range: range, string: string)
            if string.isEmpty {
                return true
            }
            if shouldChange {
                maskedView.changeTextField(str: updatedText)
            }
            return false
        }
        
        if textField == inputLimitView.getTextField(){
            if let stringTextField = textField.text {
                let (shouldChange, countChar) = manager.limitCharInString(stringTextField: stringTextField, range: range, string: string)
                if shouldChange {
                    inputLimitView.updateCharCount(count: countChar)
                    return true
                }
                return false
            }
        }
        
        if textField == noDigitsView.getTextField() {
            if let stringTextField = textField.text {
                let (shouldChange, updatedText) = manager.noNumberInString(stringTextField: stringTextField, range: range, string: string)
                if shouldChange {
                    noDigitsView.setTextField(str: updatedText)
                }
                return false
            }
        }
        return true
    }
}
// MARK: keyboard notification
extension MainViewController {
    private func addGestureRecognizers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification, textField: UITextField) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentSize.height < 900 ? scrollView.contentSize.height += keyboardHeight / 2 : nil
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.scrollView.contentSize.height -= keyboardFrame.height / 2
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            }
        }
    }
}

