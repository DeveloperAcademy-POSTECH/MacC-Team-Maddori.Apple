//
//  JoinTeamDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct JoinTeamDTO: Encodable {
    let nickname: String
    let role: String?
    let profile_image: String?
}
