//
//  AllFeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct AllFeedBackResponse: Decodable {
    // MARK: - getTeamAndUserFeedback
    let category: String?
    let userFeedback: [FeedBackResponse]?
    let teamFeedback: [FeedBackResponse]?
    
    enum CodingKeys: String, CodingKey {
        case category
        case userFeedback = "user_feedback"
        case teamFeedback = "team_feedback"
    }
}
