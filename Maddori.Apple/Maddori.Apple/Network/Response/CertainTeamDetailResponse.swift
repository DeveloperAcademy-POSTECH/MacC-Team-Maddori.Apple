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
    // FIXME: - 서버에선 1과 0으로 오는데 클라에선 true false로 처리해야함. 오류가 있을수도?
    let admin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case teamName = "team_name"
        case invitationCode = "invitation_code"
        case admin
    }
}
