//
//  AllFeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct AllFeedBackResponse: Decodable {
    let category: String?
    let userFeedback: [FeedBackContentResponse]?
    let teamFeedback: [FeedBackContentResponse]?
    
    enum CodingKeys: String, CodingKey {
        case category
        case userFeedback = "user_feedback"
        case teamFeedback = "team_feedback"
    }
}
