//
//  CountryCell.swift
//  HomeWork8
//
//  Created by Kirill Selivanov on 03.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var nameCountry = UILabel()
    var countryModel: CountryCellModel? {
        didSet {
            if let countryModel = countryModel {
                updateContent(with: countryModel)
            }
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameCountry.backgroundColor = .white
        nameCountry.textAlignment = .center
        nameCountry.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameCountry)
        setupNSLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func updateContent(with countryModel: CountryCellModel) {
        nameCountry.text = countryModel.country
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
            nameCountry.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameCountry.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameCountry.topAnchor.constraint(equalTo: topAnchor),
            nameCountry.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
