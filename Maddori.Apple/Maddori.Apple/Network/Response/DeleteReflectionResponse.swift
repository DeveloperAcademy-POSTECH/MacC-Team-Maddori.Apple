//
//  DeleteReflectionResponse.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/03/04.
//

import Foundation

struct DeleteReflectionResponse: Decodable {
    let id: Int
    let reflection_name: String?
    let date: String?
    let state: String
    let team_id: Int
}
