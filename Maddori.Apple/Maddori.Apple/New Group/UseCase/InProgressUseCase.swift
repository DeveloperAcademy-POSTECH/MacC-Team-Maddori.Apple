//
//  InProgressUseCase.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/28/23.
//

import Foundation

import Alamofire

protocol InProgressUseCase {
    var reflectionID: Int { get set }
    var reflectionUserID: Int { get set }
    
    func fetchFeedbacks(_ endpoint: InProgressEndPoint<VoidModel>) throws -> TeamFeedbackResponseDTO
}

final class InProgressUserCaseImpl: InProgressUseCase {
    
    var reflectionID: Int
    var reflectionUserID: Int
    
    init(reflectionID: Int, reflectionUserID: Int) {
        self.reflectionID = reflectionID
        self.reflectionUserID = reflectionUserID
    }
    
    func fetchFeedbacks(_ endpoint: InProgressEndPoint<VoidModel>) throws -> TeamFeedbackResponseDTO {
        let request = AF.request(endpoint.address, method: endpoint.method, headers: endpoint.headers)
        guard let data = request.data,
              let decodedData = try? JSONDecoder().decode(BaseModel<TeamFeedbackResponseDTO>.self, from: data),
              let feedbackData = decodedData.detail
        else { throw NSError(domain: "api error", code: 0) }
        
        return feedbackData
    }
}
