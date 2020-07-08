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
        
        
        network.getGlobal { (response) in
                   DispatchQueue.main.async {
                       if let response = response {
                        print("\ngetGlobal")
                        print(response.date)
                           print(response.global.newConfirmed)
                       } else {
                           print("Error")
                       }
                   }
               }
        
        network.getCountries { (response) in
            DispatchQueue.main.async {
                if let response = response {
                    print("\ngetCountries")
                    print(response.date)
                    print(response.countries[0].country)
                    print(response.countries[0].totalConfirmed)
                } else {
                    print("Error")
                }
            }
        }
        
        network.getSummary { (response) in
            DispatchQueue.main.async {
                if let response = response {
                    print("\ngetSummary")
                    print(response.date)
                    print(response.global.newConfirmed)
                    print(response.countries[0].country)
                    print(response.countries[0].totalConfirmed)
                } else {
                    print("Error")
                }
            }
        }
        
        network.getDayOne(country: country) { (response) in
            DispatchQueue.main.async {
                if let response = response {
                    print("\ngetDayOne")
                    print(response[response.count - 1].country)
                    print(response[response.count - 1].date)
                    print(response[response.count - 1].deaths)
                } else {
                    print("Error")
                }
            }
        }
    }
}

