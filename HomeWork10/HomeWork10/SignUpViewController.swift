//
//  SignUpViewController.swift
//  HomeWork10
//
//  Created by Kirill Selivanov on 09.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum registrationFields {
        static let textLogin = "Login"
        static let textPassword = "Password"
    }
    
    private enum Colors {
        static let blue = UIColor(red: 50/255.0, green: 100/255.0, blue: 230/255.0, alpha: 1)
    }
    
    // MARK: - Properties
    
    private let titleRegistration = UILabel()
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
        configureLoginTextField()
        configurePasswordTextField()
        configureRegistrationButton()
        configureStackRegistration()
        setupNSLayout()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeybord))
        view.addGestureRecognizer(tap)
    }
    
    private func configureTitleRegistration() {
        titleRegistration.translatesAutoresizingMaskIntoConstraints = false
        titleRegistration.text = "Регистрация"
        titleRegistration.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        titleRegistration.textAlignment = .center
        view.addSubview(titleRegistration)
    }
    
    private func configureLoginTextField() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .roundedRect
        loginTextField.returnKeyType = .done
        loginTextField.placeholder = registrationFields.textLogin
        view.addSubview(loginTextField)
    }
    
    
    private func configurePasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        //passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.placeholder = registrationFields.textPassword
        view.addSubview(passwordTextField)
    }

    private func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
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
        registrationStack.addArrangedSubview(loginTextField)
        registrationStack.addArrangedSubview(passwordTextField)
        registrationStack.addArrangedSubview(registrationButton)
        registrationStack.setCustomSpacing(20.0, after: titleRegistration)
        registrationStack.setCustomSpacing(20.0, after: passwordTextField)
        view.addSubview(registrationStack)
    }
    
    private func setupNSLayout() {
        NSLayoutConstraint.activate([
            registrationStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registrationStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            registrationStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        ])
    }
    
    // MARK: - Action
    
    @objc func closeKeybord() {
        view.endEditing(true)
    }
    
    @objc func registartionAction() {

        guard let textLogin = loginTextField.text, let textPassword = passwordTextField.text, textLogin != "", textPassword != ""  else {
            return
        }
        
        DefaultSetting.saveUser(login: textLogin, password: textPassword)
        
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
