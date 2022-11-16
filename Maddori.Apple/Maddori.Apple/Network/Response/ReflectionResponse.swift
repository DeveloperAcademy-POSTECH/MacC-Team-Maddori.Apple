//
//  ReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct ReflectionResponse: Decodable {
    let id: Int?
    let reflection_name: String?
    let date: String?
    let state: String?
    let team_id: Int?
}
