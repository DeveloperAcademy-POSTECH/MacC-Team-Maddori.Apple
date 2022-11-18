//
//  LoginResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct MemberResponse: Decodable {
    // MARK: - userLogin
    let id: Int?
    let username: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username
    }
}
