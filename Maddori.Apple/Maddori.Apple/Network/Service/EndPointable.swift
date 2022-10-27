//
//  EndPointable.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

protocol EndPointable {
    var requestTimeOut: Float { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
    func getURL(baseURL: String) -> String
}
