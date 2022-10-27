//
//  Requestable.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}
