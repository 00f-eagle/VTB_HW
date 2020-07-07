//
//  ViewController.swift
//  HomeWork9
//
//  Created by Kirill Selivanov on 06.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var country = "russian-federation"

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = NetworkService()
        network.getSummary { (response) in
            if response != nil {
                print("Логика с response")
            } else {
                print("Error")
            }
        }
        
        network.getDayOne(country: country) { (response) in
            if response != nil {
                print("Логика с response")
            } else {
                print("Error")
            }
            
        }
    }
}

