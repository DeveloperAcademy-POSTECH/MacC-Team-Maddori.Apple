//
//  FeedbackToMeModel.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/14.
//

import Foundation

struct FeedbackToMeModel {
    let keyword: String
    let feedbackType: FeedbackButtonType
    let from: String
    let content: String
    let start: String?
    
    #if DEBUG
    static let mockData = FeedbackToMeModel(keyword: "진행능력", feedbackType: .continueType, from: "메리", content: "며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요 며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요", start: "진행을 계속 잘해주세용수철")
    #endif
}
