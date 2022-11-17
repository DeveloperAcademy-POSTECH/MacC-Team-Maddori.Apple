//
//  LoginResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct MemberResponse: Decodable {
    // MARK: - userLogin
    let userId: Int?
    let username: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case username
    }
}
