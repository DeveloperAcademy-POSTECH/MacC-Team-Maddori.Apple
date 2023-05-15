//
//  TeamInfoResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Foundation

struct TeamInfoResponse: Decodable {
    // MARK: - getCertainTeamDetail
    let id: Int
    let teamName: String?
    let invitationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
        case invitationCode = "invitation_code"
    }
}
