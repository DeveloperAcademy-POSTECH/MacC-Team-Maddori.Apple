//
//  TeamNameResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/04/11.
//

import Foundation

struct TeamNameResponse: Decodable {
    // MARK: - getCertainTeamName, editTeamName, getUserTeamList
    let id: Int?
    let teamName: String
    let nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
        case nickname
    }
}
