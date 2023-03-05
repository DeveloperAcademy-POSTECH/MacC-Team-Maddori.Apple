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
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case userName = "username"
    }
}

// MARK: - MemberResponse v2 / conflict 방지용

struct TeamMemberResponse: Decodable {
    // MARK: - userLogin
    let id: Int?
    let nickname: String?
    let role: String?
    let profileImagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case role
        case profileImagePath = "profile_image_path"
    }
}
