//
//  GuestCell.swift
//  HomeWork7
//
//  Created by Kirill Selivanov on 02.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class GuestCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var nameGuestLabel = UILabel()
    var guestModel: GuestCellModel? {
        didSet {
            if let guestModel = guestModel {
                updateContent(with: guestModel)
            }
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameGuestLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameGuestLabel)
        setupNSLayoutConstraint()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func updateContent(with guestModel: GuestCellModel) {
        nameGuestLabel.text = guestModel.fullName
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
        nameGuestLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        nameGuestLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        nameGuestLabel.topAnchor.constraint(equalTo: topAnchor),
        nameGuestLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
