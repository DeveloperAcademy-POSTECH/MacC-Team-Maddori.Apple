//
//  CurrentReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct CurrentReflectionResponse: Decodable {
    let current_reflection_id: Int?
    let reflection_name: String?
    let reflection_date: String?
    let reflection_status: String?
    let reflection_keywords: [String]
}
