//
//  EditFeedBackDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Foundation

struct EditFeedBackDTO: Encodable {
    // MARK: - updateFeedback
    let type: FeedBackDTO
    let keyword: String
    let content: String
}
