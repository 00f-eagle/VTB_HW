//
//  ViewController.swift
//  HomeWork7
//
//  Created by Kirill Selivanov on 01.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private let spacingFromAreaToNameTableGuest = 20
    private let spacingFromNameTableGuestToTableGuest = 45
    private let identifierCell = "GuestCell"
    private let spacingCell = 50
    
    // MARK: - Properties
    
    private var nameTableGuest = UILabel()
    private let tableGuest = UITableView()
    private var cellGuest: [GuestCellModel] = [] {
        didSet {
            tableGuest.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNameTableGuest()
        configureTableGuest()
        loadGuestList()
        setupNSLayoutConstraint()
    }
    
    
    // MARK: - Configurations
    
    private func configureNameTableGuest() {
        nameTableGuest.text = "Список гостей"
        nameTableGuest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTableGuest)
    }
    
    private func configureTableGuest() {
        tableGuest.register(GuestCell.self, forCellReuseIdentifier: identifierCell)
        tableGuest.dataSource = self
        tableGuest.delegate = self
        tableGuest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableGuest)
    }
  
    private func loadGuestList() {
        
        guard let url = Bundle.main.url(forResource: "GuestList", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            cellGuest = try JSONDecoder().decode([GuestCellModel].self, from: data)
        }catch {
            print("Error")
        }
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
            nameTableGuest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.center.x - nameTableGuest.intrinsicContentSize.width/2),
            nameTableGuest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(spacingFromAreaToNameTableGuest)),
            tableGuest.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableGuest.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableGuest.topAnchor.constraint(equalTo: nameTableGuest.topAnchor, constant: CGFloat(spacingFromNameTableGuestToTableGuest)),
            tableGuest.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellGuest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? GuestCell {
            cell.guestModel = cellGuest[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(spacingCell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            cellGuest.remove(at: indexPath.row)
        }
    }
}
