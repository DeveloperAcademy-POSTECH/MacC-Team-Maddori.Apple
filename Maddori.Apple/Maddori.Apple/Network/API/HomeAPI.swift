//
//  HomeAPI.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

struct HomeAPI {
    private let apiService: Requestable
    
    init(apiService: Requestable) {
        self.apiService = apiService
    }
    
    func fetchCssList() async throws -> ResponseKeyword? {
        let request = HomeEndPoint
            .fetchCssList
            .createRequest()
        return try await apiService.request(request)
    }
    
    func dispatchCreateCss(body: CreateCssDTO) async throws -> Int? {
        let request = HomeEndPoint
            .dispatchCreateCss(body: body)
            .createRequest()
        return try await apiService.request(request)
    }
}
