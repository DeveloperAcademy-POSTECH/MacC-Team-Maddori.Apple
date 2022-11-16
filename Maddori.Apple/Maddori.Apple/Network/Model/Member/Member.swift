//
//  MemberModel.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/07.
//

import Foundation

struct Member {
    let id: Int
    let nickname: String
    
    #if DEBUG
    static let mockData: [Member] = [
        Member(id: 0, nickname: "메리"),
        Member(id: 1, nickname: "이드"),
        Member(id: 2, nickname: "진저"),
        Member(id: 3, nickname: "케미"),
        Member(id: 4, nickname: "호야")
    ]
    #endif
    
    static func getTotalMemberList() -> [String] {
        var totalMemberList: [String] = []
        
        // FIXME: - api 로 받아온 데이터 연결하기
        for member in Member.mockData {
            totalMemberList.append(member.nickname)
        }
        return totalMemberList
    }
    
    static func getMemberListExceptUser() -> [String] {
        
        // FIXME: - UserDefault에서 유저 불러오기
        let userId = 2
        var memberListExceptUser: [String] = []
        
        // FIXME: - api 로 받아온 데이터 연결하기
        for member in Member.mockData {
            if userId != member.id {
                memberListExceptUser.append(member.nickname)
            }
        }
        return memberListExceptUser
    }
}
