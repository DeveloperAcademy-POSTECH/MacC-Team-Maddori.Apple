//
//  JoinTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct JoinTeamResponse: Decodable {
    // MARK: - userJoinTeam
    let admin: Bool?
    let id: Int?
    let userId: Int?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case admin
        case id
        case userId = "user_id"
        case teamId = "team_id"
    }
}
