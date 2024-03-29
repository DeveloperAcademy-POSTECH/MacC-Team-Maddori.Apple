//
//  UserDefaultStorage.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case isLogin = "isLogin"
    case userId = "userId"
    case nickname = "nickname"
    case teamId = "teamId"
    case teamName = "teamName"
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
    case hasSeenReflectionAlert = "hasSeenReflectionAlert"
    case seenKeywordIdList = "seenKeywordIdList"
    case seenMemberIdList = "seenMemberIdList"
    case completedCurrentReflection = "completedCurrentReflection"
}

struct UserDefaultStorage {
    static var isLogin: Bool {
        return UserData<Bool>.getValue(forKey: .isLogin) ?? false
    }
    
    static var userId: Int {
        return UserData<Int>.getValue(forKey: .userId) ?? 1
    }
        
    static var nickname: String {
        return UserData<String>.getValue(forKey: .nickname) ?? ""
    }
    
    static var teamId: Int {
        return UserData<Int>.getValue(forKey: .teamId) ?? 0
    }
    
    static var teamName: String {
        return UserData<String>.getValue(forKey: .teamName) ?? ""
    }
    
    static var accessToken: String {
        return UserData<String>.getValue(forKey: .accessToken) ?? ""
    }
    
    static var refreshToken: String {
        return UserData<String>.getValue(forKey: .refreshToken) ?? ""
    }
    
    static var hasSeenReflectionAlert: Bool {
        return UserData<Bool>.getValue(forKey: .hasSeenReflectionAlert) ?? false
    }
    
    static var seenKeywordIdList: [Int] {
        return UserData<[Int]>.getValue(forKey: .seenKeywordIdList) ?? []
    }
    
    static var seenMemberIdList: [Int] {
        return UserData<[Int]>.getValue(forKey: .seenMemberIdList) ?? []
    }
    
    static var completedCurrentReflection: Bool {
        return UserData<Bool>.getValue(forKey: .completedCurrentReflection) ?? false
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
