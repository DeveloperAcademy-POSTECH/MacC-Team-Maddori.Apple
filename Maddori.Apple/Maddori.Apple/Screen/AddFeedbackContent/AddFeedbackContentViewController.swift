//
//  AddFeedbackContentViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class AddFeedbackContentViewController: BaseViewController {
    
    private let keywordMinLength: Int = 0
    private let keywordMaxLength: Int = 15
    private let textViewMaxLength: Int = 200
    private var nickname: String = "진저"
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let exitButton = ExitButton(type: .system)
    private lazy var addFeedbackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = nickname + TextLiteral.addFeedbackContentViewControllerTitleLabel
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
    private let feedbackTypeButtonView = FeedbackTypeButtonView()
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
        label.setTextWithLineHeight(text: "\(keywordMinLength)/\(keywordMaxLength)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerFeedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackContentTextView: FeedbackTextView = {
        let textview = FeedbackTextView(frame: CGRect(x: 0, y: 0, width: 327, height: 137))
        textview.placeholder = TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder
        return textview
    }()
    private let feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.addFeedbackContentViewControllerDoneButtonTitle
        button.isDisabled = true
        return button
    }()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        setupNotificationCenter()
        setupDelegate()
    }
    
    override func render() {
        view.addSubview(addFeedbackTitleLabel)
        addFeedbackTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(addFeedbackTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeButtonView)
        feedbackTypeButtonView.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackKeywordLabel)
        feedbackKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeButtonView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackKeywordTextField)
        feedbackKeywordTextField.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        view.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordTextField.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackContentTextView)
        feedbackContentTextView.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(137)
        }
        
        view.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegate() {
        feedbackKeywordTextField.delegate = self
        feedbackContentTextView.delegate = self
    }
    
    override func endEditingView() {
        if !feedbackDoneButton.isTouchInside {
            view.endEditing(true)
        }
    }
    
    private func setCounter(count: Int) {
        if count <= keywordMaxLength {
            textLimitLabel.text = "\(count)/\(keywordMaxLength)"
        }
        else {
            textLimitLabel.text = "\(keywordMaxLength)/\(keywordMaxLength)"
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
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.feedbackDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.feedbackDoneButton.transform = .identity
        })
    }
}

// MARK: - extension

extension AddFeedbackContentViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: feedbackKeywordTextField, maxLength: keywordMaxLength)
        
        let hasText = feedbackKeywordTextField.hasText
        feedbackDoneButton.isDisabled = !hasText
    }
}

extension AddFeedbackContentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder {
            textView.text = nil
            textView.textColor = .black100
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = TextLiteral.addFeedbackContentViewControllerFeedbackContentTextViewPlaceholder
            textView.textColor = .gray500
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let characterCount = newString.count
        guard characterCount <= textViewMaxLength else { return false }
        
        return true
    }
}