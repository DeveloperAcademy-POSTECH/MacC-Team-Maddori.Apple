//
//  UserResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/23.
//

import Foundation

struct UserResponse: Decodable {
    let userName: String?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case teamId = "team_id"
    }
}
