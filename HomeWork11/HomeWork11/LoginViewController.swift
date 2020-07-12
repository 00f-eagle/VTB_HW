//
//  LoginViewController.swift
//  HomeWork11
//
//  Created by Kirill Selivanov on 12.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    // MARK: - Constants
    
    private enum loginFields {
        static let textFirstName = "Имя:"
        static let textLastName = "Фамилия:"
        static let textLogin = "Логин:"
        static let textPassword = "Пароль:"
    }
    
    private enum Colors {
        static let purple = UIColor(red: 190/255.0, green: 0/255.0, blue: 190/255.0, alpha: 1)
        static let blue = UIColor(red: 50/255.0, green: 100/255.0, blue: 230/255.0, alpha: 1)
    }
    
    // MARK: - Properties
    
    private let firstNameLabel = UILabel()
    private let lastNameLabel = UILabel()
    private let loginLabel = UILabel()
    private let passwordLabel = UILabel()
    private let loginStack = UIStackView()
    private let alertCarButton = UIButton()
    private let listCarButton = UIButton()
    
    private let viewContext = AppDelegate().persistentContainer.viewContext
    private var alertController: UIAlertController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - View's configurations
    
    private func setupView() {
        
        let user = getUser()
        
        configureLabel(label: firstNameLabel, text: "Имя: \(user.firstName!)")
        configureLabel(label: lastNameLabel, text: "Фамилия: \(user.lastName!)")
        configureLabel(label: loginLabel, text: "Логин: \(user.login!)")
        configureLabel(label: passwordLabel, text: "Пароль: \(user.password!)")
        configureLoginStack()
        configureAlertCarButton()
        configureListCarButton()
        setupNSLayout()
    }
    
    private func configureLabel(label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
    }
    
    private func configureLoginStack() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        loginStack.axis = .vertical
        loginStack.spacing = 20
        loginStack.addArrangedSubview(firstNameLabel)
        loginStack.addArrangedSubview(lastNameLabel)
        loginStack.addArrangedSubview(loginLabel)
        loginStack.addArrangedSubview(passwordLabel)
        view.addSubview(loginStack)
    }
    
    private func configureAlertCarButton() {
        alertCarButton.translatesAutoresizingMaskIntoConstraints = false
        alertCarButton.layer.cornerRadius = 20
        alertCarButton.setTitle("+", for: .normal)
        alertCarButton.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        alertCarButton.addTarget(self, action: #selector(alertCar), for: .touchUpInside)
        alertCarButton.backgroundColor = Colors.purple
        view.addSubview(alertCarButton)
    }
    
    private func configureListCarButton() {
        listCarButton.translatesAutoresizingMaskIntoConstraints = false
        listCarButton.setTitle("Список машин", for: .normal)
        listCarButton.layer.cornerRadius = 5
        listCarButton.addTarget(self, action: #selector(openListCar), for: .touchUpInside)
        listCarButton.backgroundColor = Colors.blue
        view.addSubview(listCarButton)
    }
    
    private func setupNSLayout() {
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            alertCarButton.widthAnchor.constraint(equalToConstant: 40),
            alertCarButton.heightAnchor.constraint(equalToConstant: 40),
            alertCarButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            alertCarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            listCarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            listCarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            listCarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    // MARK: - Action
    
    @objc private func alertCar() {
        alertController = UIAlertController(title: "Добавить машину", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите модель машины"
            textField.delegate = self
        }
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            self.addCar(model: self.alertController.textFields![0].text!)
        }))
        alertController.actions[0].isEnabled = false
        alertController.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func openListCar() {
        let loginVC = ListCarViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    // MARK: - Core Data
    
    private func getUser() -> User {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id = %i", 1)
        var users: [User] = []
        do {
            users = try viewContext.fetch(fetchRequest)
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return users[0]
    }
    
    private func addCar(model: String) {
        let user = getUser()
        let car = Car(context: viewContext)
        car.model = model
        user.addToCar(car)
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !(range.location == 0 && range.length == 1) {
            alertController.actions[0].isEnabled = true
        }else{
            alertController.actions[0].isEnabled = false
        }
        return true;
    }
}
