//
//  CurrentMemberResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct MemberDetailResponse: Decodable {
    let userId: Int?
    let userName: String?
    let role: String?
    let profileImagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case userName = "nickname"
        case role = "role"
        case profileImagePath = "profile_image_path"
    }
}


struct TeamMembersResponse: Decodable {
    // MARK: - getTeamMembers
    let members: [MemberDetailResponse]?
}
