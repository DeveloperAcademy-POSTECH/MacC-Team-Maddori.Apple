//
//  SendFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/03.
//

import UIKit

import Alamofire
import SnapKit

enum Step {
    case writeSituation
    case writeFeeling
    case writeSuggestions
}

final class AddFeedbackContentViewController: BaseViewController {
    
    private enum Size {
        static let topPadding: Int = 8
        static let stepTopPadding: Int = 24
        static let descriptionTopPadding: Int = 12
    }
    
    var feedbackContent: FeedbackContent
    
    var step: Step
    var currentStepString: String = ""
    
    var textViewHasText: Bool = false
    
    init(feedbackContent: FeedbackContent, step: Step) {
        self.feedbackContent = feedbackContent
        self.step = step
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedBackButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var closeButton: CloseButton = {
        let button = CloseButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedCloseButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        switch step {
        case .writeSituation:
            return UIImageView(image: ImageLiterals.imgProgress2)
        case .writeFeeling:
            return UIImageView(image: ImageLiterals.imgProgress3)
        case .writeSuggestions:
            return UIImageView(image: ImageLiterals.imgProgress4)
        }
    }()
    private lazy var currentStepLabel: UILabel = {
        let label = UILabel()
        switch step {
        case .writeSituation:
            label.text = TextLiteral.addFeedbackContentViewControllerCurrentStepLabel2
        case .writeFeeling:
            label.text = TextLiteral.addFeedbackContentViewControllerCurrentStepLabel3
        case .writeSuggestions:
            label.text = TextLiteral.addFeedbackContentViewControllerCurrentStepLabel4
        }
        label.textColor = .black100
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.numberOfLines = 2
        return label
    }()
    private lazy var currentStepDescriptionLabel: UILabel = {
        let label = UILabel()
        let text: String
        switch step {
        case .writeSituation:
            text = TextLiteral.addFeedbackContentViewControllerCurrentStepDescriptionLabel2
        case .writeFeeling:
            text = TextLiteral.addFeedbackContentViewControllerCurrentStepDescriptionLabel3
        case .writeSuggestions:
            text = TextLiteral.addFeedbackContentViewControllerCurrentStepDescriptionLabel4
        }
        label.textColor = .gray400
        label.font = .body2
        label.setTextWithLineHeight(text: text, lineHeight: 20)
        label.numberOfLines = 0
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let feedbackContentTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .white200
        view.font = .body1
        return view
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonNext
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
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationCenter()
        feedbackContentTextView.becomeFirstResponder()
            
        if let contentString = feedbackContent.contentString {
            feedbackContent.contentString = contentString.replacingOccurrences(of: "\(currentStepString)|\n\n\(currentStepString)", with: "", options: .regularExpression)
        }
    }
    
    override func render() {
        view.addSubview(progressImageView)
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Size.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(currentStepLabel)
        currentStepLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(progressImageView.snp.bottom).offset(Size.stepTopPadding)
        }
        
        view.addSubview(currentStepDescriptionLabel)
        currentStepDescriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(currentStepLabel.snp.bottom).offset(Size.descriptionTopPadding)
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(currentStepDescriptionLabel.snp.bottom).offset(20)
            $0.height.equalTo(1)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-2)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(feedbackContentTextView)
        feedbackContentTextView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(doneButton.snp.top)
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegate() {
        feedbackContentTextView.delegate = self
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    private func didTappedDoneButton() {
        if step != .writeSituation {
            if let contentString = feedbackContent.contentString {
                if contentString.isEmpty {
                    feedbackContent.contentString = currentStepString
                } else {
                    feedbackContent.contentString = contentString + "\n\n" + currentStepString
                }
            }
        }
        
        DispatchQueue.main.async {
            switch self.step {
            case .writeSituation:
                self.navigationController?.pushViewController(AddFeedbackContentViewController(feedbackContent: self.feedbackContent, step: Step.writeFeeling), animated: true)
            case .writeFeeling:
                self.navigationController?.pushViewController(AddFeedbackContentViewController(feedbackContent: self.feedbackContent, step: Step.writeSuggestions), animated: true)
            case .writeSuggestions:
                self.navigationController?.pushViewController(AddFeedbackKeywordViewController(feedbackContent: self.feedbackContent), animated: true)
                // FIXME: 키워드 작성하는 마지막 단계 VC가 생기면 그 VC로 연결
            }
        }
        // FIXME: currentStepString과 쌓여가는 contentString 볼 수 있도록 해 둔 코드 -> 머지 전에 지우기
//        print("currentStepString: \(currentStepString)")
//        print("contentString: \(contentString)")
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        feedbackContentTextView.snp.updateConstraints {
            $0.bottom.equalTo(doneButton.snp.top).offset(-keyboardSize.height + 15)
        }
        UIView.animate(withDuration: 0, animations: {
            self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        feedbackContentTextView.snp.updateConstraints {
            $0.bottom.equalTo(doneButton.snp.top).offset(-10)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - extension

extension AddFeedbackContentViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        textViewHasText = feedbackContentTextView.hasText
        doneButton.isDisabled = !textViewHasText
        
        guard let text = textView.text else { return }
        currentStepString = text
    }
}
