//
//  EditFeedbackFromMeViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import SnapKit

final class EditFeedbackFromMeViewController: AddFeedbackContentViewController {
    
    private let model = FeedbackFromMeModel.mockData
    
    // MARK: - property
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setupFeedbackType()
        setupFeedbackKeyword()
    }
    
    // MARK: - func
    
    private func setupFeedbackType() {
        switch model.feedbackType {
        case .continueType:
            self.feedbackTypeButtonView.touchUpToSelectType(.continueType)
        case .stopType:
            self.feedbackTypeButtonView.touchUpToSelectType(.stopType)
        }
    }
    
    private func setupFeedbackKeyword() {
        
    }
}
