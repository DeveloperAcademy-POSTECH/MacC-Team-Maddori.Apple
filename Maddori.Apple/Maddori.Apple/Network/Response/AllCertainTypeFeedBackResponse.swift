//
//  AllCertainTypeFeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct AllCertainTypeFeedBackResponse: Decodable {
    // MARK: - getCertainTypeFeedbackAll-id
    let feedback: [FeedBackResponse]
}
