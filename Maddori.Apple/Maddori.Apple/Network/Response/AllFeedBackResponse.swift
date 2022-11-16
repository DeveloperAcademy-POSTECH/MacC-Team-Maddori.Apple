//
//  AllFeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct AllFeedBackResponse: Decodable {
    let category: String?
    let user_feedback: [FeedBackContentResponse]?
    let team_feedback: [FeedBackContentResponse]?
}
