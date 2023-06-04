//
//  FeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct FeedBackResponse: Decodable {
    let id: Int?
    let type: FeedBackType?
    let keyword: String?
    let content: String?
    let fromUser: MemberResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case keyword
        case content
        case fromUser = "from_user"
    }
}
