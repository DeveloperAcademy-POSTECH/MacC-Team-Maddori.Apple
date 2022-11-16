//
//  JoinTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct JoinTeamResponse: Decodable {
    let admin: Bool?
    let id: Int?
    let user_id: Int?
    let team_id: Int?
}
