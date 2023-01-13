//
//  FeedbackContent .swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/09.
//

import Foundation

struct FeedbackContent {
    let toNickName: String?
    let toUserId: Int?
    let feedbackType: FeedBackDTO?
    var situation: String?
    var feeling: String?
    var suggestion: String?
    let reflectionId: Int
    
    var content: String {
        (situation ?? "") + "\n\n" + (feeling ?? "") + "\n\n" + (suggestion ?? "")
    }
}
