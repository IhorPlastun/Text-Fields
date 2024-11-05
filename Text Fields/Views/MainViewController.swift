//
//  ViewController.swift
//  Text Fields
//
//  Created by Igor Plastun on 29.10.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let manager = TextFieldsManagers()
    //MARK: ui elements
    private let headerLabel: UILabel = {
        var label = UILabel()
        label.text = "Text Fields"
        label.font = .systemFont(ofSize: .init(30))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let withoutNumberLabel: UILabel = {
        var label = UILabel()
        label.text = "NO digits field"
        label.font = .systemFont(ofSize: .init(15))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let withoutNumbersTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Type here"
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
    
    private let maskedLabel: UILabel = {
        var label = UILabel()
        label.text = "Only characters"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maskedTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "wwwwww-ddddd"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
    
    private let passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Validation rules"
        label.font = .systemFont(ofSize: .init(15))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let rulesLengthCharLabel: UILabel = {
        var label = UILabel()
        label.text = "Min length 8 characters."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesCountNumLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 digit."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesLowercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 lowercase."
        label.font = .systemFont(ofSize: .init(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesUppercaseLabel: UILabel = {
        var label = UILabel()
        label.text = "Minimum 1 uppercase."
        label.font = .systemFont(ofSize: .init(13))
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
        keyboardView.backgroundColor = .red
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
        withoutNumbersTextField.delegate = self
        inputLimitTextField.delegate = self
        maskedTextField.delegate = self
        linkTextField.delegate = self
        passwordTextField.delegate = self
    }
    
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
    // MARK: serup UI
    private func setUpUI() {
        let arrViews = [ headerLabel, withoutNumberLabel ,withoutNumbersTextField, inputLimitLabel, countCharLabel, inputLimitTextField,
                         maskedLabel, maskedTextField, linkLabel, linkTextField, passwordLabel, passwordTextField, rulesLengthCharLabel,
                         rulesCountNumLabel, rulesLowercaseLabel, rulesUppercaseLabel ]
        
        Helper.shared.addSubviews(subviews: [scrollView], view: self.view)
        scrollView.addSubview(contentView)
        Helper.shared.addSubviews(subviews: arrViews, view:self.view)
        Helper.shared.addBackgroundForTextField(subviews: arrViews, parentView: self.view)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            withoutNumberLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            withoutNumberLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            withoutNumberLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            withoutNumbersTextField.topAnchor.constraint(equalTo: withoutNumberLabel.bottomAnchor, constant: 10),
            withoutNumbersTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            withoutNumbersTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48),
            
            inputLimitLabel.topAnchor.constraint(equalTo: withoutNumbersTextField.bottomAnchor, constant: 40),
            inputLimitLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            countCharLabel.topAnchor.constraint(equalTo: withoutNumbersTextField.bottomAnchor, constant: 40),
            countCharLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            inputLimitTextField.topAnchor.constraint(equalTo: inputLimitLabel.bottomAnchor, constant: 10),
            inputLimitTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            inputLimitTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48),
            
            maskedLabel.topAnchor.constraint(equalTo: inputLimitTextField.bottomAnchor, constant: 40),
            maskedLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            maskedTextField.topAnchor.constraint(equalTo: maskedLabel.bottomAnchor, constant: 10),
            maskedTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            maskedTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48),
            
            linkLabel.topAnchor.constraint(equalTo: maskedTextField.bottomAnchor, constant: 40),
            linkLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 10),
            linkTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            linkTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48),
            
            passwordLabel.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48),
            
            rulesLengthCharLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            rulesLengthCharLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            rulesCountNumLabel.topAnchor.constraint(equalTo: rulesLengthCharLabel.bottomAnchor, constant: 10),
            rulesCountNumLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            rulesLowercaseLabel.topAnchor.constraint(equalTo: rulesCountNumLabel.bottomAnchor, constant: 10),
            rulesLowercaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            rulesUppercaseLabel.topAnchor.constraint(equalTo: rulesLowercaseLabel.bottomAnchor, constant: 10),
            rulesUppercaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            rulesUppercaseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150)
        ])
    }
}
// MARK: TextField delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == linkTextField {
            guard var strURL = textField.text else { return true }
            if let alert = manager.openUrl(strURL: strURL) {
                present(alert, animated: true, completion: nil)
            }
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            let arrLabels: [UILabel] = [rulesLowercaseLabel, rulesUppercaseLabel, rulesCountNumLabel, rulesLengthCharLabel]
            return manager.validPasswordRules(textField: textField, range: range, string: string, labels: arrLabels)
        }
        
        if textField == maskedTextField {
            return manager.maskedTextField(textField: textField, range: range, string: string)
        }
        
        if textField == inputLimitTextField {
            return manager.limitCharInString(textField: textField, range: range, string: string, label: countCharLabel)
        }
        
        if textField == withoutNumbersTextField {
            return manager.noNumberInString(textField: textField, range: range, string: string)
        }
        return true
    }
}
// MARK: keyboard notification
extension MainViewController {
    @objc private func keyboardWillShow(notification: Notification, textField: UITextField) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentSize.height += keyboardHeight / 2
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

