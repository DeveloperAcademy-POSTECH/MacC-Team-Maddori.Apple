//
//  TeamNameResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/04/11.
//

import Foundation

struct TeamNameResponse: Decodable {
    let id: Int
    let teamName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
    }
}
