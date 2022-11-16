//
//  CreateTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CreateTeamResponse: Decodable {
    let id: Int?
    let teamName: String?
    let invitationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
        case invitationCode = "invitation_code"
    }
}
