//
//  AddFeedbackDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct AddFeedbackDTO: Encodable {
    let type: String
    let keyword: String
    let content: String
    let start_content: String
    let to_id: Int
}
