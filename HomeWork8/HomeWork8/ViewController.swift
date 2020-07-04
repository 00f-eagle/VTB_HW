//
//  ViewController.swift
//  HomeWork8
//
//  Created by Kirill Selivanov on 03.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants
    
    private let identifierCell = "CountryCell"
    private let countries = ["Russia", "USA", "Brazil", "India", "China", "Canada", "France", "Germany", "Spain", "Latvia", "Litva", "Estonia", "Sweden"]
    private let spacingCellInteritem = CGFloat(50)
    private let spacingCellLine = CGFloat(10)
    private let sizeCell = CGSize(width: 100, height: 30)
    private let edgeSection = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // MARK: - Properties
    
    private let collectionCountry = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    private var cellCountry: [CountryCellModel] = [] {
        didSet {
            collectionCountry.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionCountry()
        loadCountryList()
        setupNSLayoutConstraint()
    }
    
    // MARK: - Configurations
    
    private func configureCollectionCountry() {
        collectionCountry.delegate = self
        collectionCountry.dataSource = self
        collectionCountry.translatesAutoresizingMaskIntoConstraints = false
        collectionCountry.backgroundColor = .red
        collectionCountry.register(CountryCell.self, forCellWithReuseIdentifier: identifierCell)
        view.addSubview(collectionCountry)
        
        if let flowLayout = collectionCountry.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = sizeCell
            flowLayout.sectionInset = edgeSection
            flowLayout.minimumLineSpacing = spacingCellLine
            flowLayout.minimumInteritemSpacing = spacingCellInteritem
        }
    }
    
    private func loadCountryList() {
        for country in countries {
            cellCountry.append(CountryCellModel(country: country))
        }
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
            collectionCountry.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionCountry.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionCountry.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionCountry.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCountry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as? CountryCell {
            cell.countryModel = cellCountry[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
}
