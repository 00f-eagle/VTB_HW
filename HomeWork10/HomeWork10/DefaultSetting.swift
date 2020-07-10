//
//  DefaultSetting.swift
//  HomeWork10
//
//  Created by Kirill Selivanov on 10.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct DefaultSetting {
    
    // MARK: - Constants
    
    private enum Keys {
        static let login = "login"
        static let password = "password"
        static let isLogin = "isLogin"
    }
    
    private static let userDefault = UserDefaults.standard
    
    // MARK: - Save UserDefault
    
    static func saveUser(login: String, password: String){
        userDefault.set(login, forKey: Keys.login)
        userDefault.set(password, forKey: Keys.password)
        userDefault.set(true, forKey: Keys.isLogin)
    }
    
    // MARK: - Get UserDefault
    
    static func getLogin() -> String {
        return userDefault.value(forKey: Keys.login) as? String ?? "Error"
    }
    
    static func getPassword() -> String {
        return userDefault.value(forKey: Keys.password) as? String ?? "Error"
    }
    
    static func getIsLogin() -> Bool {
        return userDefault.value(forKey: Keys.isLogin) as? Bool ?? false
    }
    
    // MARK: - Delete UserDefault
    
    static func deleteUser(){
        userDefault.removeObject(forKey: Keys.login)
        userDefault.removeObject(forKey: Keys.password)
        userDefault.removeObject(forKey: Keys.isLogin)
    }
}
