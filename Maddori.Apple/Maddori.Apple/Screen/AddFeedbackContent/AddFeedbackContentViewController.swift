//
//  AddFeedbackContentViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class AddFeedbackContentViewController: BaseViewController {
    private let homeService = HomeAPI(apiService: APIService())
    
    private enum Length {
        static let keywordMinLength: Int = 0
        static let keywordMaxLength: Int = 15
        static let textViewMaxLength: Int = 200
    }
    var type: CSSType = .Continue
    var fromNickname: String
    var toNickname: String
    
    init(from: String, to: String) {
        self.fromNickname = from
        self.toNickname = to
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
    
    private lazy var exitButton: ExitButton = {
        let button = ExitButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedExitButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let addFeedbackScrollView = UIScrollView()
    private let addFeedbackContentView = UIView()
    private lazy var addFeedbackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = toNickname + TextLiteral.addFeedbackContentViewControllerTitleLabel
        label.textColor = .black100
        label.font = .title
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackTypeLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackTypeButtonView: FeedbackTypeButtonView = {
        let view = FeedbackTypeButtonView()
        view.changeFeedbackType = { [weak self] type in
            if let typeValue = CSSType.init(rawValue: type.rawValue) {
                self?.type = typeValue
            }
        }
        return view
    }()
    private let feedbackKeywordLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackKeywordLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackKeywordTextField: KigoTextField = {
        let textField = KigoTextField()
        textField.placeHolderText = TextLiteral.addFeedbackContentViewControllerFeedbackKeywordTextFieldPlaceholder
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
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackTextViewLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackContentOptionalLabel: UILabel = {
        let label = UILabel()
        label.text = "(선택사항)"
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    private let feedbackContentTextView: FeedbackTextView = {
        let textView = FeedbackTextView()
        textView.placeholder = TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder
        return textView
    }()
    private lazy var feedbackStartSwitch: UISwitch = {
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
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackStartLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackStartTextViewLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackTextViewLabel
        label.textColor = .black100
        label.font = .label2
        label.isHidden = true
        return label
    }()
    private let feedbackStartTextView: FeedbackTextView = {
        let textView = FeedbackTextView()
        textView.placeholder = TextLiteral.addFeedbackContentViewControllerStartTextViewPlaceholder
        textView.isHidden = true
        return textView
    }()
    private let feedbackDoneButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white200
        return view
    }()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.addFeedbackContentViewControllerDoneButtonTitle
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
            $0.height.equalTo(view.frame.height)
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
        
        addFeedbackScrollView.addSubview(feedbackContentOptionalLabel)
        feedbackContentOptionalLabel.snp.makeConstraints {
            $0.leading.equalTo(feedbackContentLabel.snp.trailing).offset(2)
            $0.bottom.equalTo(feedbackContentLabel.snp.bottom)
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
    }
        
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        let exitButton = makeBarButtonItem(with: exitButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = exitButton
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
    
    private func setCounter(count: Int) {
        if count <= Length.keywordMaxLength {
            textLimitLabel.text = "\(count)/\(Length.keywordMaxLength)"
        }
        else {
            textLimitLabel.text = "\(Length.keywordMaxLength)/\(Length.keywordMaxLength)"
        }
    }
    
    private func checkMaxLength(textField: UITextField, maxLength: Int) {
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
    
    private func didTappedExitButton() {
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
        postCreateCss()
    }
    
    // MARK: - selector
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.feedbackDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }
    
    @objc private func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.feedbackDoneButton.transform = .identity
        })
    }
    
    // MARK: - API
    
    private func postCreateCss() {
        Task {
            do {
                guard let keyword = feedbackKeywordTextField.text,
                      let content = feedbackContentTextView.text,
                      let startContent = feedbackStartTextView.text else { return }
                let dto = CreateCssDTO(from_name: fromNickname, to_name: toNickname, type: type, keyword: keyword, content: content, start_content: startContent)
                if let data = try await homeService.dispatchCreateCss(body: dto) {
                    dump(data)
                    dismiss(animated: true)
                }
            } catch NetworkError.serverError {
                print("serverError")
            } catch NetworkError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
}

// MARK: - extension

extension AddFeedbackContentViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: feedbackKeywordTextField, maxLength: Length.keywordMaxLength)
        
        let hasText = feedbackKeywordTextField.hasText
        feedbackDoneButton.isDisabled = !hasText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addFeedbackScrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: 375.0, height: 850.0), animated: true)
    }
}

extension AddFeedbackContentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder || textView.text == TextLiteral.addFeedbackContentViewControllerStartTextViewPlaceholder {
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
            textView.text = textView == feedbackContentTextView ? TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder : TextLiteral.addFeedbackContentViewControllerStartTextViewPlaceholder
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
