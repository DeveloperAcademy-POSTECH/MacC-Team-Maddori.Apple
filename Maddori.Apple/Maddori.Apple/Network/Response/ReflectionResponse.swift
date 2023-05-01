//
//  ReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct ReflectionResponse: Decodable {
    // MARK: - patchReflectionDetail, deleteReflectionDetail, endInProgressReflection
    let id: Int?
    let reflectionName: String?
    let date: String?
    let state: ReflectionStatus?
    let teamId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case reflectionName = "reflection_name"
        case date
        case state
        case teamId = "team_id"
    }
}
