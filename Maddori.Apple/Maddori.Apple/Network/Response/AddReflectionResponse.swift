//
//  AddReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct AddReflectionResponse: Decodable {
    let id: Int?
    let reflectionName: String?
    let date: String?
    let state: String?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case reflectionName = "reflection_name"
        case date
        case state
        case teamId = "team_id"
    }
}
