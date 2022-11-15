//
//  AddReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct AddReflectionResponse: Decodable {
    let id: Int?
    let reflection_name: String?
    let date: String?
    let state: String?
    let team_id: Int?
}
