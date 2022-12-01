//
//  TeamInfoResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Foundation

struct TeamInfoResponse: Decodable {
    // MARK: - getCertainTeamName
    let id: Int?
    let teamName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
    }
}
