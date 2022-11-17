//
//  UserDefaultStorage.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case isLogin = "isLogin"
    case userID = "userID"
    case nickname = "nickname"
    case teamId = "teamId"
}

struct UserDefaultStorage {
    static var isLogin: Bool {
        return UserData<Bool>.getValue(forKey: .isLogin) ?? false
    }
    
    static var userID: Int {
        return UserData<Int>.getValue(forKey: .userID) ?? 1
    }
        
    static var nickname: String {
        return UserData<String>.getValue(forKey: .nickname) ?? ""
    }
    
    static var teamId: Int {
        return UserData<Int>.getValue(forKey: .teamId) ?? 1
    }
}

struct UserData<T> {
    static func getValue(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
    
    static func setValue(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func clearAll() {
        DataKeys.allCases.forEach { key in
            print(key.rawValue)
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func clear(forKey key: DataKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
