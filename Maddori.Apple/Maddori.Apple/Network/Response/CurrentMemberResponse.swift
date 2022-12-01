//
//  CurrentMemberResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct TeamMembersResponse: Decodable {
    // MARK: - getTeamMembers
    let members: [MemberResponse]?
}
