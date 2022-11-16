//
//  CurrentReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CurrentReflectionResponse: Decodable {
    let currentReflectionId: Int?
    let reflectionName: String?
    let reflectionDate: String?
    let reflectionStatus: String?
    let reflectionKeywords: [String]?
    
    enum CodingKeys: String, CodingKey {
        case currentReflectionId = "current_reflection_id"
        case reflectionName = "reflection_name"
        case reflectionDate = "reflection_date"
        case reflectionStatus = "reflection_status"
        case reflectionKeywords = "reflection_keywords"
    }
}
