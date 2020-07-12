//
//  ListCarViewController.swift
//  HomeWork11
//
//  Created by Kirill Selivanov on 12.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
import CoreData

class ListCarViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum settingsCell {
        static let identifierCell = "CarCell"
        static let spacingCell = CGFloat(50)
    }
    
    //MARK: - Properties
    
    private let navBar = UINavigationBar()
    private let carTable = UITableView()
    private var carCell: [String] = [] {
        didSet {
            carTable.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        loadCarList()
        configureNavBar()
        configureCarTable()
        setupNSLayout()
    }
    
    private func configureNavBar() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Список машин")
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: #selector(back))
        navBar.setItems([navItem], animated: false)
        navBar.barTintColor = .white
        view.addSubview(navBar)
    }
    
    private func configureCarTable() {
        carTable.register(CarCell.self, forCellReuseIdentifier: settingsCell.identifierCell)
        carTable.dataSource = self
        carTable.delegate = self
        carTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carTable)
    }
    
    private func loadCarList() {
        let viewContext = AppDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Car>(entityName: "Car")
        var cars: [Car] = []
        do {
            cars = try viewContext.fetch(fetchRequest)
            for car in cars {
                if car.ofUser?.id == 1 {
                    carCell.append(car.model!)
                }
            }
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    private func setupNSLayout() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            carTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carTable.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            carTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Activate
    
    @objc private func back() {
        dismiss(animated: true)
    }
    
    // MARK: - Core Data
    
    private func deleteCar(model: String) {
        let viewContext = AppDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Car>(entityName: "Car")
        do {
            let cars = try viewContext.fetch(fetchRequest)

            for car in cars {
                if car.model == model {
                    viewContext.delete(car)
                }
            }
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension ListCarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: settingsCell.identifierCell, for: indexPath) as? CarCell {
            cell.carName = carCell[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return settingsCell.spacingCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deleteCar(model: carCell[indexPath.row])
            carCell.remove(at: indexPath.row)
        }
    }
}
