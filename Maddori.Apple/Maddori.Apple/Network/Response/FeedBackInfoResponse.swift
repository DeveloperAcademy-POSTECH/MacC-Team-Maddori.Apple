//
//  FeedBackInfoResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackInfoResponse: Decodable {
    let team_id: Int?
    let reflection_id: Int?
    let reflection_name: String?
    let reflection_status: String?
    let from_id: Int?
    let to_id: Int?
    let to_username: String?
    let Continue: [KeywordResponse]
    let Stop: [KeywordResponse]
}
