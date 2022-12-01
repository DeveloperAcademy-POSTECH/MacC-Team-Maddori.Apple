//
//  CertainTeamDetailResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CertainTeamDetailResponse: Decodable {
    // MARK: - getCertainTeamDetail
    let teamId: Int?
    let teamName: String?
    let invitationCode: String?
    let admin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case teamName = "team_name"
        case invitationCode = "invitation_code"
        case admin
    }
}
