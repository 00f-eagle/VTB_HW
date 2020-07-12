//
//  CarCell.swift
//  HomeWork11
//
//  Created by Kirill Selivanov on 12.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    // MARK: - Properties
    
    private var nameCarLabel = UILabel()
    var carName: String? {
        didSet {
            if let carName = carName {
                updateContent(with: carName)
            }
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameCarLabel.translatesAutoresizingMaskIntoConstraints = false
        nameCarLabel.textAlignment = .center
        addSubview(nameCarLabel)
        setupNSLayoutConstraint()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func updateContent(with carModel: String) {
        nameCarLabel.text = carModel
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
        nameCarLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        nameCarLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        nameCarLabel.topAnchor.constraint(equalTo: topAnchor),
        nameCarLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
