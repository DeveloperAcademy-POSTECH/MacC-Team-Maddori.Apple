//
//  CurrentReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

enum ReflectionStatus: String, Decodable {
    case SettingRequired
    case Before
    case Progressing
    case Done
}

struct CurrentReflectionResponse: Decodable {
    // MARK: - getCurrentReflectionDetail
    let currentReflectionId: Int?
    let reflectionName: String?
    let reflectionDate: String?
    let reflectionStatus: ReflectionStatus?
    let reflectionKeywords: [String]?
    
    enum CodingKeys: String, CodingKey {
        case currentReflectionId = "current_reflection_id"
        case reflectionName = "reflection_name"
        case reflectionDate = "reflection_date"
        case reflectionStatus = "reflection_status"
        case reflectionKeywords = "reflection_keywords"
    }
}
