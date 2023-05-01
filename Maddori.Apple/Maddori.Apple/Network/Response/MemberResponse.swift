//
//  LoginResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct MemberResponse: Decodable {
    let id: Int?
    let nickname: String?
}

struct MemberDetailResponse: Decodable {
    // MARK: - editProfile
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
