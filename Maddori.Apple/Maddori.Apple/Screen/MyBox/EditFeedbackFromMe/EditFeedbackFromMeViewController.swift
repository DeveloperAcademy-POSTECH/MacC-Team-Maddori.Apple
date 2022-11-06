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
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setupFeedbackType()
        setupFeedbackKeyword()
        setupFeedbackContent()
        setupFeedbackStart()
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
        feedbackKeywordTextField.text = model.keyword
        setCounter(count: model.keyword.count)
    }
    
    private func setupFeedbackContent() {
        feedbackContentTextView.text = model.info
        feedbackContentTextView.textColor = .black100
    }
    
    private func setupFeedbackStart() {
        if let start = model.start {
            feedbackStartSwitch.isOn = true
            feedbackStartTextViewLabel.isHidden = false
            feedbackStartTextView.isHidden = false
            feedbackStartTextView.text = start
            feedbackStartTextView.textColor = .black100
        }
    }
}
