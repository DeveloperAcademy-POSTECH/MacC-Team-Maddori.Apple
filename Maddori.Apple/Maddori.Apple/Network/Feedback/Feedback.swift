//
//  Feedback.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import Foundation

struct FeedBack {
    let type: FeedBackType
    let title: String
    let content: String
    let from: String
    let to: String
    
    init(type: FeedBackType, title: String, content: String, from: String, to: String) {
        self.type = type
        self.title = title
        self.content = content
        self.from = from
        self.to = to
    }
    
    #if DEBUG
    static let mockData: [FeedBack] = [
        FeedBack(type: .continueType, title: "필기능력", content: "Continue~~", from: "케미", to: "호야"),
        FeedBack(type: .continueType, title: "두둥탁", content: "Continue 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 두둥탁 너무 좋아요~ 너무 좋아요~너무 좋아요~너무 좋아요~", from: "케미", to: "호야"),
        FeedBack(type: .continueType, title: "정리정돈", content: "Continue 스프린트 때 유독 행사가 많았는데 그때마다 행사 전후로 정리정돈 잘 해주셔서 감사해요 ! 특히 행사 끝나고 분리수거 깔끔해주신 게 인상 깊어요 ㅋㅋ 앞으로 우리 팀의 청결 지킴이 해주실거죠? 잘 부탁드립니다 ~", from: "케미", to: "호야"),
        FeedBack(type: .stopType, title: "멈출줄모르는", content: "Stop 좋아요~ 너무 좋아요~ 너무 좋아요 ~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~너무 좋아요~너무 좋아요~", from: "케미", to: "호야"),
        FeedBack(type: .stopType, title: "토끼", content: "Stop 좋아요~ 너무 좋아요~ 너무 좋아요 ~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~너무 좋아요~너무 좋아요~", from: "케미", to: "호야"),
        FeedBack(type: .stopType, title: "진저비어", content: "Stop 좋아요~ 너무 좋아요~ 너무 좋아요~", from: "케미", to: "호야"),
        FeedBack(type: .stopType, title: "불도저", content: "Stop 좋아요~ 너무 좋아요~ 너무 좋아요 ~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~너무 좋아요~너무 좋아요~", from: "케미", to: "호야"),
        FeedBack(type: .continueType, title: "진저비어", content: "좋아요~좋아요~좋아요~좋아요~좋아요~좋아요~좋아요", from: "케미", to: "호야"),
        FeedBack(type: .stopType, title: "불도저", content: "Start 좋아요~ 너무 좋아요~ 너무 좋아요 ~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~너무 좋아요~너무 좋아요~", from: "케미", to: "호야")
    ]
    #endif
}
