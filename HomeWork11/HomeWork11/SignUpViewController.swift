//
//  SignUpViewController.swift
//  HomeWork11
//
//  Created by Kirill Selivanov on 10.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    // MARK: - Constants
    
    private enum registrationFields {
        static let textFirstName = "First Name"
        static let textLastName = "Last Name"
        static let textLogin = "Login"
        static let textPassword = "Password"
    }
    
    private enum Colors {
        static let blue = UIColor(red: 50/255.0, green: 100/255.0, blue: 230/255.0, alpha: 1)
    }
    
    // MARK: - Properties
    
    private let titleRegistration = UILabel()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registrationButton = UIButton()
    private let registrationStack = UIStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Configurations
    
    func setupView() {
        configureTitleRegistration()
        configureTextField(textField: firstNameTextField, text: registrationFields.textFirstName)
        configureTextField(textField: lastNameTextField, text: registrationFields.textLastName)
        configureTextField(textField: loginTextField, text: registrationFields.textLogin)
        configureTextField(textField: passwordTextField, text: registrationFields.textPassword)
        passwordTextField.isSecureTextEntry = true
        configureRegistrationButton()
        configureStackRegistration()
        setupNSLayout()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeybord))
        view.addGestureRecognizer(tap)
    }
    
    private func configureTextField(textField: UITextField, text: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = text
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = .systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        view.addSubview(textField)
    }
    
    private func configureTitleRegistration() {
        titleRegistration.text = "Регистрация"
        titleRegistration.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        titleRegistration.textAlignment = .center
        view.addSubview(titleRegistration)
    }

    private func configureRegistrationButton() {
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.layer.cornerRadius = 3
        registrationButton.addTarget(self, action: #selector(registartionAction), for: .touchUpInside)
        registrationButton.backgroundColor = Colors.blue
        view.addSubview(registrationButton)
    }
    
    private func configureStackRegistration() {
        registrationStack.translatesAutoresizingMaskIntoConstraints = false
        registrationStack.axis = .vertical
        registrationStack.addArrangedSubview(titleRegistration)
        registrationStack.addArrangedSubview(firstNameTextField)
        registrationStack.addArrangedSubview(lastNameTextField)
        registrationStack.addArrangedSubview(loginTextField)
        registrationStack.addArrangedSubview(passwordTextField)
        registrationStack.addArrangedSubview(registrationButton)
        registrationStack.spacing = 10
        registrationStack.setCustomSpacing(20.0, after: titleRegistration)
        registrationStack.setCustomSpacing(20.0, after: passwordTextField)
        view.addSubview(registrationStack)
    }
    
    private func setupNSLayout() {
        NSLayoutConstraint.activate([
            registrationStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registrationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registrationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    // MARK: - Action
    
    @objc func closeKeybord() {
        view.endEditing(true)
    }
    
    @objc func registartionAction() {
        
        guard let textFirstName = firstNameTextField.text, let textLastName = lastNameTextField.text, let textLogin = loginTextField.text, let textPassword = passwordTextField.text, textFirstName != "", textLastName != "", textLogin != "", textPassword != ""  else {
            return
        }

        let viewContext = AppDelegate().persistentContainer.viewContext

        let user = User(context: viewContext)
        user.firstName = textFirstName
        user.lastName = textLastName
        user.login = textLogin
        user.password = textPassword
        user.id = 1

        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}

