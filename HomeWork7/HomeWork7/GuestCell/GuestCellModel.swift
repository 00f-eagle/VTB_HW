//
//  GuestCell.swift
//  HomeWork7
//
//  Created by Kirill Selivanov on 02.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

// MARK: - Model

struct GuestCellModel: Decodable {
    private let name: String
    private let surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }

    var fullName: String {
        return name + " " + surname
    }
}
