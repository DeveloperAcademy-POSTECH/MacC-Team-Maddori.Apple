//
//  Endpointable.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/18.
//

import Alamofire

protocol EndPointable {
    associatedtype T
    var address: String { get }
    var method: HTTPMethod { get }
    var body: T? { get }
    var headers: HTTPHeaders? { get }
}
