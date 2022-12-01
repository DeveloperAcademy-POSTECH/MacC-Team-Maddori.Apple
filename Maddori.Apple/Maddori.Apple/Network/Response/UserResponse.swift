//
//  UserResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/23.
//

import Foundation

struct UserResponse: Decodable {
    let userId: Int?
    let userName: String?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userName = "username"
        case teamId = "team_id"
    }
}
