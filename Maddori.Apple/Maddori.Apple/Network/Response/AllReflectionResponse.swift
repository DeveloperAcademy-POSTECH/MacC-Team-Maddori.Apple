//
//  AllReflectionResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct AllReflectionResponse: Decodable {
    // MARK: - getPastReflectionList
    let reflection: [[ReflectionResponse]?]?
}
