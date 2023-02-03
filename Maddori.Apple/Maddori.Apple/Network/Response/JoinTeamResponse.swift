//
//  JoinTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct JoinTeamResponse: Decodable {
    // MARK: - userJoinTeam
    let id: Int?
    let nickname: String?
    let role: String?
    let profileImagePath: String?
    let userId: Int?
    let team: CreateTeamResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case role
        case profileImagePath = "profile_image_path"
        case userId = "user_id"
        case team
    }
}
