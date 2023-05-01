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
    let user: LoginUserResponse?
    
    enum CodingKeys: String, CodingKey {
        case created
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case user
    }
}

struct LoginUserResponse: Decodable {
    let userId: Int?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case teamId = "team_id"
    }
}
