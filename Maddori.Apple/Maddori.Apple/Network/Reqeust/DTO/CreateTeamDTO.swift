//
//  CreateTeamDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CreateTeamDTO: Encodable {
    // MARK: - createTeam
    let team_name: String
    let nickname: String
    let role: String?
}
