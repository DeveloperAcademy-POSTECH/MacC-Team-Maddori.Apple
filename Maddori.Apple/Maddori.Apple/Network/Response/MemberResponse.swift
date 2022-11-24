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
        case userId = "user_id"
        case userName = "username"
    }
}

// FIXME: - 서버의 response값이 통일되지 않아서 두 가지로 나누어 사용하다 추후에 서버에서 합치면 그 때 둘 중 하나를 없앱니다.
struct JoinMemberResponse: Decodable {
    let id: Int?
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
    }
}
