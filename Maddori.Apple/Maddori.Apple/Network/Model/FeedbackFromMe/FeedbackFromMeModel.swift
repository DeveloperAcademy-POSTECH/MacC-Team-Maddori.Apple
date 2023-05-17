//
//  FeedbackFromMeModel.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/02.
//

import Foundation

enum FeedbackButtonType: String {
    case continueType = "Continue"
    case stopType = "Stop"
}

struct FeedbackFromMeModel {
    let reflectionId: Int
    let feedbackId: Int
    let nickname: String
    let feedbackType: FeedbackButtonType
    let keyword: String
    let info: String
    let reflectionStatus: ReflectionStatus
}

