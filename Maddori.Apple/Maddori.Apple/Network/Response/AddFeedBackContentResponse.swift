//
//  AddFeedBackContentResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct AddFeedBackContentResponse: Decodable {
    let id: Int?
    let type: String?
    let keyword: String?
    let content: String?
    let start_content: String?
    let from_id: Int?
    let to_id: Int?
    let team_id: Int?
    let reflection_id: Int?
}
