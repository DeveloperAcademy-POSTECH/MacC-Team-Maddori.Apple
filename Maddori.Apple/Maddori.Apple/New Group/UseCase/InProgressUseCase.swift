//
//  InProgressUseCase.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/28/23.
//

import Foundation

protocol InProgressUseCase {
    var reflectionID: Int { get set }
    var reflectionUserID: Int { get set }
    
    func fetchFeedbacks(_ endpoint: InProgressEndPoint<VoidModel>) -> AllFeedBackResponse
}

final class InProgressUserCaseImpl: InProgressUseCase {
    
    var reflectionID: Int
    var reflectionUserID: Int
    
    init(reflectionID: Int, reflectionUserID: Int) {
        self.reflectionID = reflectionID
        self.reflectionUserID = reflectionUserID
    }
    
    func fetchFeedbacks(_ endpoint: InProgressEndPoint<VoidModel>) -> AllFeedBackResponse {
        
    }
}
