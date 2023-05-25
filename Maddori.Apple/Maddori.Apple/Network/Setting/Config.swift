//
//  Config.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/05/25.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let baseUrl = "BASE_URL"
            static let imageBaseUrl = "IMAGE_BASE_URL"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot be found.")
        }
        return dict
    }()
    
}

extension Config {
    
    static let baseUrl: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseUrl] as? String
        else { fatalError("baseUrl not fetched from info.plist") }
        return key
    }()
    
    static let imageBaseUrl: String = {
        guard let key = Config.infoDictionary[Keys.Plist.imageBaseUrl] as? String
        else { fatalError("imageBaseUrl not fetched from info.plist") }
        return key
    }()
    
}
