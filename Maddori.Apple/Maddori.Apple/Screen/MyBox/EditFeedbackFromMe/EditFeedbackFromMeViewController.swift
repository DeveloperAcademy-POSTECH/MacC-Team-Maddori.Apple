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
    private var isFeedbackTypeChanged: Bool = false {
        didSet {
            if !(isTextInputChanged() || isFeedbackTypeChanged) {
                feedbackDoneButton.isDisabled = true
            } else {
                feedbackDoneButton.isDisabled = false
            }
        }
    }
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setupFeedbackType()
        setupFeedbackKeyword()
        setupFeedbackContent()
        setupFeedbackStart()
        hideEditFeedbackUntilLabel()
        detectChangeOfFeedbackType()
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
    
    private func hideEditFeedbackUntilLabel() {
        editFeedbackUntilLabel.isHidden = true
        feedbackDoneButtonView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
        }
    }
    
    @objc override func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.feedbackDoneButton.transform = .identity
        })
        editFeedbackUntilLabel.isHidden = true
    }
    
    // MARK: - extension
    
    override func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: feedbackKeywordTextField, maxLength: Length.keywordMaxLength)
        feedbackDoneButton.isDisabled = !(isTextInputChanged() || isFeedbackTypeChanged)
    }
    
    override func textViewDidChangeSelection(_ textView: UITextView) {
        feedbackDoneButton.isDisabled = !(isTextInputChanged() || isFeedbackTypeChanged)
    }
    
    private func isTextInputChanged() -> Bool {
        if feedbackContentTextView.text == model.info &&
            feedbackStartTextView.text == model.start &&
            feedbackKeywordTextField.text == model.keyword {
            return false
        } else {
            return true
        }
    }
    
    private func detectChangeOfFeedbackType() {
        feedbackTypeButtonView.changeFeedbackType = { value in
            if value == self.model.feedbackType {
                self.isFeedbackTypeChanged = false
            } else {
                self.isFeedbackTypeChanged = true
            }
        }
    }
}
