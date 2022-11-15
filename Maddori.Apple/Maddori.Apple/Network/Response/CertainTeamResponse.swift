//
//  CertainTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CertainTeamResponse: Decodable {
    let team_id: Int?
    let team_name: String?
    let invitation_code: String?
    let admin: Bool?
}
