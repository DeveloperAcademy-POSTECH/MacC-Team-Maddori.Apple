//
//  AddFeedbackContentViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import Alamofire
import SnapKit

class AddFeedbackViewController: BaseViewController {
    
    enum Length {
        static let keywordMinLength: Int = 0
        static let keywordMaxLength: Int = 15
        static let textViewMaxLength: Int = 200
    }
    var type: FeedBackDTO = .continueType
    var toNickname: String
    var toUserId: Int
    var keywordHasText: Bool = false
    var contentHasText: Bool = false
    
    init(to: String, toUserId: Int) {
        self.toNickname = to
        self.toUserId = toUserId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // FIXME: - 회고 날짜 받아오기 / 현재는 있는 상태
    private let feedbackDate: Date? = Date()
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedBackButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var closeButton: CloseButton = {
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
    lazy var feedbackTypeButtonView: FeedbackTypeButtonView = {
        let view = FeedbackTypeButtonView()
        view.changeFeedbackType = { [weak self] type in
            if let typeValue = FeedBackDTO.init(rawValue: type.rawValue) {
                self?.type = typeValue
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
    let feedbackKeywordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeHolderText = TextLiteral.addFeedbackViewControllerFeedbackKeywordTextFieldPlaceholder
        return textField
    }()
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
    let feedbackContentTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.placeholder = TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder
        return textView
    }()
    lazy var feedbackStartSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .blue200
        toggle.isOn = false
        let action = UIAction { [weak self] _ in
            self?.didTappedSwitch()
        }
        toggle.addAction(action, for: .touchUpInside)
        return toggle
    }()
    private let feedbackStartLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackViewControllerFeedbackStartLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    let feedbackStartTextViewLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        label.isHidden = true
        return label
    }()
    let feedbackStartTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.placeholder = TextLiteral.addFeedbackViewControllerStartTextViewPlaceholder
        textView.isHidden = true
        return textView
    }()
    let feedbackDoneButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white200
        return view
    }()
    let editFeedbackUntilLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.addFeedbackViewControllerFeedbackSendTimeLabel, lineHeight: 22)
        label.textColor = .gray400
        label.font = .body2
        return label
    }()
    lazy var feedbackDoneButton: MainButton = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupDelegate()
    }
    
    override func render() {
        view.addSubview(addFeedbackScrollView)
        addFeedbackScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addFeedbackScrollView.addSubview(addFeedbackContentView)
        addFeedbackContentView.snp.makeConstraints {
            $0.edges.equalTo(addFeedbackScrollView.snp.edges)
            $0.width.equalTo(addFeedbackScrollView.snp.width)
            $0.height.equalTo(1180)
        }
        
        addFeedbackContentView.addSubview(addFeedbackTitleLabel)
        addFeedbackTitleLabel.snp.makeConstraints {
            $0.top.equalTo(addFeedbackContentView.snp.top).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.leadingTrailingPadding)
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
        
        addFeedbackContentView.addSubview(feedbackKeywordTextField)
        feedbackKeywordTextField.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        addFeedbackContentView.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordTextField.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackContentTextView)
        feedbackContentTextView.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(150)
        }
        
        addFeedbackContentView.addSubview(feedbackStartSwitch)
        feedbackStartSwitch.snp.makeConstraints {
            $0.top.equalTo(feedbackContentTextView.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(51)
            $0.height.equalTo(31)
        }
        
        addFeedbackContentView.addSubview(feedbackStartLabel)
        feedbackStartLabel.snp.makeConstraints {
            $0.centerY.equalTo(feedbackStartSwitch.snp.centerY)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackStartTextViewLabel)
        feedbackStartTextViewLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackStartSwitch.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addFeedbackContentView.addSubview(feedbackStartTextView)
        feedbackStartTextView.snp.makeConstraints {
            $0.top.equalTo(feedbackStartTextViewLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(150)
        }
        
        view.addSubview(feedbackDoneButtonView)
        feedbackDoneButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        feedbackDoneButtonView.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(feedbackDoneButtonView.snp.bottom).inset(36)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackDoneButtonView.addSubview(editFeedbackUntilLabel)
        editFeedbackUntilLabel.snp.makeConstraints {
            $0.bottom.equalTo(feedbackDoneButton.snp.top).offset(-11)
            $0.centerX.equalTo(feedbackDoneButtonView.snp.centerX)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegate() {
        feedbackKeywordTextField.delegate = self
        feedbackContentTextView.delegate = self
        feedbackStartTextView.delegate = self
    }
    
    override func endEditingView() {
        if !feedbackDoneButton.isTouchInside {
            view.endEditing(true)
        }
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
                    self.feedbackKeywordTextField.text = String(fixedText)
                }
            }
        }
    }
    
    private func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    private func didTappedSwitch() {
        feedbackStartTextViewLabel.isHidden.toggle()
        feedbackStartTextView.isHidden.toggle()
        
        if feedbackStartSwitch.isOn {
            addFeedbackScrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: 375.0, height: 1100.0), animated: true)
            addFeedbackContentView.snp.updateConstraints {
                $0.height.equalTo(1180)
            }
        }
        else {
            addFeedbackContentView.snp.updateConstraints {
                $0.height.equalTo(view.frame.height)
            }
        }
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func didTappedDoneButton() {
        let startContent = feedbackStartSwitch.isOn ? feedbackStartTextView.text : nil
        guard let keyword = feedbackKeywordTextField.text,
              let content = feedbackContentTextView.text
        else { return }
        let dto = FeedBackContentDTO(type: type, keyword: keyword, content: content, start_content: startContent, to_id: toUserId)
        // FIXME: - 각 id들 UserDefault에 저장되어 있는 값을 불러와야 함.
        dispatchAddFeedBack(type: .dispatchAddFeedBack(teamId: 1.description, reflectionId: 2.description, userId: 1.description, dto))
    }
    
    // MARK: - api
    
    private func dispatchAddFeedBack(type: AddFeedBackEndPoint<FeedBackContentDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<FeedBackContentResponse>.self) { json in
            dump(json.value)
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - selector
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.feedbackDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
        editFeedbackUntilLabel.isHidden = true
    }
    
    @objc func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.feedbackDoneButton.transform = .identity
        })
        editFeedbackUntilLabel.isHidden = false
    }
}

// MARK: - extension

extension AddFeedbackViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: feedbackKeywordTextField, maxLength: Length.keywordMaxLength)
        
        keywordHasText = feedbackKeywordTextField.hasText
        feedbackDoneButton.isDisabled = !(keywordHasText && contentHasText)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addFeedbackScrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: 375.0, height: 850.0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        feedbackContentTextView.becomeFirstResponder()
    }
}

extension AddFeedbackViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        contentHasText = feedbackContentTextView.hasText && feedbackContentTextView.text != TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder
        feedbackDoneButton.isDisabled = !(keywordHasText && contentHasText)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder || textView.text == TextLiteral.addFeedbackViewControllerStartTextViewPlaceholder {
            textView.text = nil
            textView.textColor = .black100
        }
        
        if textView == feedbackContentTextView {
            addFeedbackScrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: 375.0, height: 920.0), animated: true)
        } else {
            addFeedbackScrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: 375.0, height: 1100.0), animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textView == feedbackContentTextView ? TextLiteral.addFeedbackViewControllerFeedbackContentTextViewPlaceholder : TextLiteral.addFeedbackViewControllerStartTextViewPlaceholder
            textView.textColor = .gray500
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let characterCount = newString.count
        guard characterCount <= Length.textViewMaxLength else { return false }
        
        return true
    }
}
