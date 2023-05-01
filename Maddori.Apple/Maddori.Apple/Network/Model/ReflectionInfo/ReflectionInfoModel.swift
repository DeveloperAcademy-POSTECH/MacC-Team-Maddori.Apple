//
//  ReflectionInfoModel.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import Foundation

enum FeedBackType: String, CaseIterable, Decodable {
    case continueType = "Continue"
    case stopType = "Stop"
}

struct ReflectionInfoModel {
    let nickname: String
    let feedbackType: FeedBackType
    let keyword: String
    let info: String
    
    static let mockData = ReflectionInfoModel(nickname: "곰민", feedbackType: .continueType, keyword: "정리정돈", info: "이번 스프린트 때 유독 행사가 많았는데 그때마다 행사 전후로 정리정돈 잘 해주셔서 감사해요 ! 특히 행사 끝나고 분리수거 깔끔해주신 게 인상 깊어요 ㅋㅋ 앞으로 우리 팀의 청결 지킴이 해주실거죠? 잘 부탁드립니다 ~")
}
