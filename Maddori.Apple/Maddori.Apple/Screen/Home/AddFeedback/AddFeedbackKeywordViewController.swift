//
//  AddFeedbackKeywordViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/04.
//

import UIKit

import Alamofire
import SnapKit

final class AddFeedbackKeywordViewController: BaseViewController {
    
    private enum Length {
        static let keywordMaxLength: Int = 10
    }
    private enum Size {
        static let stepTopPadding: Int = 24
    }

    let placeholder = TextLiteral.addFeedbackKeywordViewControllerPlaceholder
    var textViewHasText: Bool = false
    var textFieldWidth: CGFloat = 0
    var placeholderWidth: CGFloat {
        let placeholder = TextLiteral.addFeedbackKeywordViewControllerPlaceholder
        let fontAttributes = [NSAttributedString.Key.font: UIFont.main]
        let width = (placeholder as NSString).size(withAttributes: fontAttributes).width
        return width
    }
    
    let toString: String
    let toUserId: Int
    let feedbackType: FeedBackDTO
    let contentString: String
    let reflectionId: Int
    
    init(to: String, toUserId: Int, type: FeedBackDTO, content: String, reflectionId: Int) {
        self.toString = to
        self.toUserId = toUserId
        self.feedbackType = type
        self.contentString = content
        self.reflectionId = reflectionId
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
    private let progressImageView = UIImageView(image: ImageLiterals.imgProgress5)
    private let currentStepLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerCurrentStepLabel5
        label.textColor = .black100
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.numberOfLines = 2
        return label
    }()
    private let keywordTextField = KeywordTextField()
    private let containerScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .blue300
        view.layer.cornerRadius = 10
        view.contentInset.top = 20
        view.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 6)
        return view
    }()
    private lazy var scrollContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.toLabel,
            self.toDescriptionLabel,
            self.typeLabel,
            self.typeDescriptionLabel,
            self.feedbackLabel,
            self.feedbackDescriptionLabel
        ])
        for i in 0..<stackView.arrangedSubviews.count {
            stackView.setCustomSpacing(i % 2 == 0 ? 8 : 24, after: stackView.subviews[i])
        }
        stackView.axis = .vertical
        return stackView
    }()
    private let toLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .gray600
        label.text = TextLiteral.addFeedbackContentViewControllerToLabel
        return label
    }()
    private lazy var toDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .gray400
        label.text = toString
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .gray600
        label.text = TextLiteral.addFeedbackContentViewControllerTypeLabel
        return label
    }()
    private lazy var typeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .gray400
        label.text = feedbackType.rawValue
        return label
    }()
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .gray600
        label.text = TextLiteral.addFeedbackContentViewControllerContentLabel
        label.numberOfLines = 0
        return label
    }()
    private lazy var feedbackDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .gray400
        label.numberOfLines = 0
        label.text = contentString
        return label
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonComplete
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
        setupNavigationBar()
        setupNotificationCenter()
        setupTextFieldObserver()
    }
    
    override func render() {
        view.addSubview(progressImageView)
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(currentStepLabel)
        currentStepLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(progressImageView.snp.bottom).offset(Size.stepTopPadding)
        }
        
        view.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(currentStepLabel.snp.bottom).offset(28)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-2)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(containerScrollView)
        containerScrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(keywordTextField.textFieldContainerView.snp.bottom).offset(32)
            $0.bottom.equalTo(doneButton.snp.top).offset(-12)
        }
        
        containerScrollView.addSubview(scrollContentStackView)
        scrollContentStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.width.equalToSuperview().offset(-2 * SizeLiteral.leadingTrailingPadding)
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
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    private func setupTextFieldObserver() {
        keywordTextField.keywordTextField.addTarget(self, action: #selector(changeDoneButtonStatus), for: .editingChanged)
    }
    
    private func didTappedDoneButton() {
        guard let keyword = keywordTextField.keywordTextField.text else { return }
        let dto = FeedBackContentDTO(type: feedbackType, keyword: keyword, content: contentString, start_content: nil, to_id: toUserId)
        dispatchAddFeedBack(type: .dispatchAddFeedBack(reflectionId: reflectionId, dto))
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            containerScrollView.snp.updateConstraints {
                 $0.bottom.equalTo(doneButton.snp.top).offset(-keyboardSize.height + 12)
             }
            UIView.animate(withDuration: 0.2, animations: {
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        containerScrollView.snp.updateConstraints {
            $0.bottom.equalTo(doneButton.snp.top).offset(-12)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func changeDoneButtonStatus() {
        if keywordTextField.keywordTextField.hasText {
            doneButton.isDisabled = false
        } else {
            doneButton.isDisabled = true
        }
    }
}
