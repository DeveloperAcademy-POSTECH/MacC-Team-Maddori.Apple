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
    let start: String?
    
    static let mockData = FeedbackFromMeModel(reflectionId: 0, feedbackId: 0, nickname: "곰민", feedbackType: .stopType, keyword: "정리정돈", info: "이번 스프린트 때 유독 행사가 많았는데 그때마다 행사 전후로 정리정돈 잘 해주셔서 감사해요 ! 특히 행사 끝나고 분리수거 깔끔해주신 게 인상 깊어요 ㅋㅋ", start: "새로운 제안이라고 하면 좀 이상할 수도 있지만 앞으로도 계속 청결함을 지켜주는 역할 해주시길.. 최고의 선생님 !!!!")
}

