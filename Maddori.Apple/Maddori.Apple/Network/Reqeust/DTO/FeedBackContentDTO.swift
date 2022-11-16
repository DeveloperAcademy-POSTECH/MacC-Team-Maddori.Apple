//
//  AddFeedbackDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackContentDTO: Encodable {
    let type: FeedBackDTO
    let keyword: String
    let content: String
    let start_content: String
    let to_id: Int
    
    enum FeedBackDTO: String, Encodable {
        case continueType = "Continue"
        case stopType = "Stop"
    }
}
