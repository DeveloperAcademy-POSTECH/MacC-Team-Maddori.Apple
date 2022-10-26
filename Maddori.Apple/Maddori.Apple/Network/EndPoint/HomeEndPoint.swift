//
//  HomeEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

enum HomeEndPoint: EndPointable {
    case fetchCssList
    case dispatchCreateCss(body: CreateCssDTO)
    
    var requestTimeOut: Float {
        return 10
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchCssList:
            return .GET
        case .dispatchCreateCss:
            return .POST
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .fetchCssList:
            return nil
        case .dispatchCreateCss(let info):
            return info.encode()
        }
    }
    
    func getURL(baseURL: String) -> String {
        switch self {
        case .fetchCssList:
            return "\(baseURL)/css/keywords"
        case .dispatchCreateCss:
            return "\(baseURL)/css"
        }
    }
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(baseURL: APIEnvironment.baseUrl),
                              headers: headers,
                              reqBody: requestBody,
                              reqTimeout: requestTimeOut,
                              httpMethod: httpMethod
        )
    }
}