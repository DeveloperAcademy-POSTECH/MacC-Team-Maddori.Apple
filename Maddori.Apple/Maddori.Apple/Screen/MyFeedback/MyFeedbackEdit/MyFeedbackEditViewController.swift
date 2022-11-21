//
//  EditFeedbackFromMeViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import Alamofire
import SnapKit

final class MyFeedbackEditViewController: AddFeedbackViewController {
    private let feedbackDetail: FeedbackFromMeModel
    private var isFeedbackTypeChanged: Bool = false {
        didSet {
            if !(isTextInputChanged() || isFeedbackTypeChanged) {
                super.feedbackDoneButton.isDisabled = true
            } else {
                super.feedbackDoneButton.isDisabled = false
            }
        }
    }
    
    // MARK: - life cycle
    
    init(feedbackDetail: FeedbackFromMeModel) {
        self.feedbackDetail = feedbackDetail
        super.init(to: feedbackDetail.nickname, toUserId: 0, reflectionId: feedbackDetail.reflectionId)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedbackType()
        setupFeedbackKeyword()
        setupFeedbackContent()
        setupFeedbackStart()
        hideEditFeedbackUntilLabel()
        detectChangeOfFeedbackType()
        setupNavigationRightItem()
    }
    
    // MARK: - func
    
    private func setupFeedbackType() {
        switch feedbackDetail.feedbackType {
        case .continueType:
            super.feedbackTypeButtonView.touchUpToSelectType(.continueType)
        case .stopType:
            super.feedbackTypeButtonView.touchUpToSelectType(.stopType)
        }
    }
    
    private func setupFeedbackKeyword() {
        super.feedbackKeywordTextField.text = feedbackDetail.keyword
        super.setCounter(count: feedbackDetail.keyword.count)
    }
    
    private func setupFeedbackContent() {
        super.feedbackContentTextView.text = feedbackDetail.info
        super.feedbackContentTextView.textColor = .black100
    }
    
    private func setupFeedbackStart() {
        if let start = feedbackDetail.start {
            super.feedbackStartSwitch.isOn = true
            super.feedbackStartTextViewLabel.isHidden = false
            super.feedbackStartTextView.isHidden = false
            super.feedbackStartTextView.text = start
            super.feedbackStartTextView.textColor = .black100
        }
    }
    
    private func hideEditFeedbackUntilLabel() {
        super.editFeedbackUntilLabel.isHidden = true
        super.feedbackDoneButtonView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
        }
    }
    
    private func isTextInputChanged() -> Bool {
        if super.feedbackContentTextView.text == feedbackDetail.info &&
            super.feedbackStartTextView.text == feedbackDetail.start ?? TextLiteral.addFeedbackViewControllerStartTextViewPlaceholder &&
            super.feedbackKeywordTextField.text == feedbackDetail.keyword {
            return false
        } else {
            return true
        }
    }
    
    private func detectChangeOfFeedbackType() {
        super.feedbackTypeButtonView.changeFeedbackType = { [weak self] value in
            if value == self?.feedbackDetail.feedbackType {
                self?.isFeedbackTypeChanged = false
            } else {
                self?.isFeedbackTypeChanged = true
            }
        }
    }
    
    private func setupNavigationRightItem() {
        super.closeButton.isHidden = true
    }
    
    // MARK: - selector
    
    @objc override func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            super.feedbackDoneButton.transform = .identity
        })
        super.editFeedbackUntilLabel.isHidden = true
    }
    
    // MARK: - api
    
    private func putEditFeedBack(type: MyFeedBackEndPoint<EditFeedBackDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<EditFeedBackResponse>.self) { json in
            if let data = json.value {
                dump(data)
            }
        }
    }
    
    // MARK: - extension
    
    override func textFieldDidChangeSelection(_ textField: UITextField) {
        super.setCounter(count: textField.text?.count ?? 0)
        super.checkMaxLength(textField: super.feedbackKeywordTextField, maxLength: Length.keywordMaxLength)
        super.feedbackDoneButton.isDisabled = !(isTextInputChanged() || isFeedbackTypeChanged)
    }
    
    override func textViewDidChangeSelection(_ textView: UITextView) {
        super.feedbackDoneButton.isDisabled = !(isTextInputChanged() || isFeedbackTypeChanged)
    }
}
