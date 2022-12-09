//
//  EditFeedbackFromMeViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import Alamofire
import SnapKit

final class MyFeedbackEditViewController: BaseViewController {
    private enum Length {
        static let keywordMinLength: Int = 0
        static let keywordMaxLength: Int = 10
        static let textViewMaxLength: Int = 200
    }
    private var type: FeedBackDTO = .continueType
    private let toNickname: String
    private let toUserId: Int
    private let currentReflectionId: Int
    private var keywordHasText: Bool = false
    private var contentHasText: Bool = false
    private let parentNavigationViewController: UINavigationController
    private var feedbackType: FeedBackDTO
    private let feedbackDetail: FeedbackFromMeModel
    private var isStartSwitchToggleChanged: Bool = false {
        didSet {
            if !(isTextInputChanged() || isFeedbackTypeChanged || isStartSwitchToggleChanged) {
                feedbackDoneButton.isDisabled = true
            } else {
                feedbackDoneButton.isDisabled = false
            }
        }
    }
    private var isFeedbackTypeChanged: Bool = false {
        didSet {
            if !(isTextInputChanged() || isFeedbackTypeChanged || isStartSwitchToggleChanged) {
                feedbackDoneButton.isDisabled = true
            } else {
                feedbackDoneButton.isDisabled = false
            }
        }
    }
    
    // MARK: - property
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedCloseButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let addFeedbackScrollView = UIScrollView()
    private let addFeedbackContentView = UIView()
    private lazy var addFeedbackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = toNickname + TextLiteral.addFeedbackViewControllerTitleLabel
        label.textColor = .black100
        label.font = .title
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackTypeLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackTypeButtonView: FeedbackTypeButtonView = {
        let view = FeedbackTypeButtonView()
        view.changeFeedbackType = { [weak self] type in
            if let typeValue = FeedBackDTO.init(rawValue: type.rawValue) {
                self?.type = typeValue
                guard let keyword = self?.keywordTextFieldView.keywordTextField.text,
                      let content = self?.feedbackContentTextView.text
                else { return }
                let hasKeyword = keyword.isEmpty,
                    hasContent = content == TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder
                if !hasKeyword && !hasContent {
                    self?.feedbackDoneButton.isDisabled = false
                }
            }
        }
        return view
    }()
    private let feedbackKeywordLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackKeywordLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var keywordTextFieldView = KeywordTextFieldView(placeHolder: feedbackDetail.keyword)
    private lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(Length.keywordMinLength)/\(Length.keywordMaxLength)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackContentTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.placeholder = TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder
        return textView
    }()
    private let feedbackDoneButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white200
        return view
    }()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.addFeedbackViewControllerDoneButtonTitle
        button.isDisabled = true
        let action = UIAction { [weak self] _ in
            self?.didTappedDoneButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    init(feedbackDetail: FeedbackFromMeModel,
         parentNavigationViewController: UINavigationController,
         to: String,
         toUserId: Int,
         reflectionId: Int
    ) {
        self.feedbackDetail = feedbackDetail
        self.feedbackType = FeedBackDTO.init(rawValue: feedbackDetail.feedbackType.rawValue) ?? .continueType
        self.parentNavigationViewController = parentNavigationViewController
        self.toNickname = to
        self.toUserId = toUserId
        self.currentReflectionId = reflectionId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedbackType()
        setupFeedbackKeyword()
        setupFeedbackContent()
        hideEditFeedbackUntilLabel()
        detectChangeOfFeedbackType()
    }
    
    override func render() {
        view.addSubview(addFeedbackScrollView)
        addFeedbackScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addFeedbackScrollView.addSubview(addFeedbackContentView)
        addFeedbackContentView.snp.makeConstraints {
            $0.width.top.bottom.equalToSuperview()
        }
        
        addFeedbackContentView.addSubview(addFeedbackTitleLabel)
        addFeedbackTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(addFeedbackTitleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackTypeButtonView)
        feedbackTypeButtonView.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackKeywordLabel)
        feedbackKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeButtonView.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(keywordTextFieldView)
        keywordTextFieldView.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(keywordTextFieldView.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        addFeedbackContentView.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(keywordTextFieldView.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackContentTextView)
        feedbackContentTextView.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(feedbackDoneButtonView)
        feedbackDoneButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        feedbackDoneButtonView.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(feedbackDoneButtonView.snp.bottom).inset(36)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    // MARK: - func
    
    private func setupDelegate() {
        feedbackContentTextView.delegate = self
        keywordTextFieldView.keywordTextField.delegate = self
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    private func setupFeedbackType() {
        switch feedbackDetail.feedbackType {
        case .continueType:
            feedbackTypeButtonView.feedbackType = .continueType
        case .stopType:
            feedbackTypeButtonView.feedbackType = .stopType
        }
    }
    
    private func setupFeedbackKeyword() {
        keywordTextFieldView.keywordTextField.text = feedbackDetail.keyword
        setCounter(count: feedbackDetail.keyword.count)
    }
    
    private func setupFeedbackContent() {
        feedbackContentTextView.text = feedbackDetail.info
        feedbackContentTextView.textColor = .black100
    }
        
    private func hideEditFeedbackUntilLabel() {
        feedbackDoneButtonView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
        }
    }
    
    private func isTextInputChanged() -> Bool {
        if feedbackContentTextView.text == feedbackDetail.info &&
            keywordTextFieldView.keywordTextField.text == feedbackDetail.keyword {
            return false
        } else {
            return true
        }
    }
    
    private func detectChangeOfFeedbackType() {
        feedbackTypeButtonView.changeFeedbackType = { [weak self] type in
            guard let feedbackType = FeedBackDTO.init(rawValue: type.rawValue) else { return }
            if type == self?.feedbackDetail.feedbackType {
                self?.isFeedbackTypeChanged = false
                self?.feedbackType = feedbackType
            } else {
                self?.isFeedbackTypeChanged = true
                self?.feedbackType = feedbackType
            }
        }
    }
    
    func didTappedDoneButton() {
        let dto = EditFeedBackDTO(type: feedbackType,
                                  keyword: keywordTextFieldView.keywordTextField.text ?? "",
                                  content: feedbackContentTextView.text ?? "",
                                  start_content: nil)
        putEditFeedBack(type: .putEditFeedBack(reflectionId: feedbackDetail.reflectionId, feedBackId: feedbackDetail.feedbackId, dto))
    }
    
    func setCounter(count: Int) {
        if count <= Length.keywordMaxLength {
            textLimitLabel.text = "\(count)/\(Length.keywordMaxLength)"
        }
        else {
            textLimitLabel.text = "\(Length.keywordMaxLength)/\(Length.keywordMaxLength)"
        }
    }
    
    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if let text = textField.text {
            if text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + " "
                
                DispatchQueue.main.async {
                    self.keywordTextFieldView.keywordTextField.text = String(fixedText)
                }
            }
        }
    }
    
    // MARK: - selector
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.feedbackDoneButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
        feedbackDoneButtonView.snp.updateConstraints {
            $0.height.equalTo(100)
        }
    }
    
    @objc func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.feedbackDoneButtonView.transform = .identity
        })
        feedbackDoneButtonView.snp.updateConstraints {
            $0.height.equalTo(134)
        }
    }
    
    // MARK: - api
    
    private func putEditFeedBack(type: MyFeedBackEndPoint<EditFeedBackDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<EditFeedBackResponse>.self) { json in
            if let _ = json.value {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.parentNavigationViewController.popViewController(animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - extension

extension MyFeedbackEditViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: keywordTextFieldView.keywordTextField, maxLength: Length.keywordMaxLength)
        
        keywordHasText = keywordTextFieldView.keywordTextField.hasText
        feedbackDoneButton.isDisabled = !(keywordHasText && contentHasText && feedbackTypeButtonView.feedbackType != nil)
    }
}

extension MyFeedbackEditViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        contentHasText = feedbackContentTextView.hasText && feedbackContentTextView.text != TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder
        feedbackDoneButton.isDisabled = !(keywordHasText && contentHasText && feedbackTypeButtonView.feedbackType != nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder || textView.text == TextLiteral.addFeedbackViewControllerStartTextViewPlaceholder {
            textView.text = nil
            textView.textColor = .black100
        }
    }
}
