//
//  AppleLoginResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/23.
//

import Foundation

struct AppleLoginResponse: Decodable {
    let created: Bool?
    let accessToken: String?
    let refreshToken: String?
    let user: UserResponse?
    
    enum CodingKeys: String, CodingKey {
        case created
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case user
    }
}
