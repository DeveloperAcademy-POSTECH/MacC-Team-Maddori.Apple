//
//  JoinTeamDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct JoinTeamDTO: Encodable {
    // MARK: - userJoinTeam, editProfile
    let nickname: String
    let role: String?
}
