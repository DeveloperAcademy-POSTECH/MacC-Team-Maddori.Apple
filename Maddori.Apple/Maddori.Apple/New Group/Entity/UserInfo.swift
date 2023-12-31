//
//  UserInfo.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/29/23.
//

import Foundation

struct UserInfo: Decodable, Hashable {
    let id: Int
    let nickname: String
}