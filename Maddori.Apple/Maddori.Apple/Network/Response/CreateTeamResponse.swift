//
//  CreateTeamResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CreateTeamResponse: Decodable {
    let id: Int?
    let team_name: String?
    let invitation_code: String?
}
