//
//  LoginViewController.swift
//  HomeWork10
//
//  Created by Kirill Selivanov on 10.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Constants
    
    private enum loginFields {
        static let textLogin = "Ваш логин: \(DefaultSetting.getLogin())"
        static let textPassword = "Ваш пароль: \(DefaultSetting.getPassword())"
    }
    
    // MARK: - Properties
    
    private let loginLabel = UILabel()
    private let passwordLabel = UILabel()
    private let loginStack = UIStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        configureTextLogin()
        configureTextPassword()
        configureLoginStack()
        setupNSLayout()
    }
    
    private func configureTextLogin() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = loginFields.textLogin
    }
    
    private func configureTextPassword() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = loginFields.textPassword
    }
    
    private func configureLoginStack() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        loginStack.axis = .vertical
        loginStack.addArrangedSubview(loginLabel)
        loginStack.addArrangedSubview(passwordLabel)
        view.addSubview(loginStack)
    }
    
    private func setupNSLayout() {
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
}
