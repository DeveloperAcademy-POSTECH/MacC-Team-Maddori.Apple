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
    
    enum Size {
        static let topPadding: Int = 8
        static let stepTopPadding: Int = 24
        static let keywordTextFieldHeight: CGFloat = 50
        static let initialTextFieldWidth: CGFloat = 32
    }
//    var currentStepString: String = ""
//    var contentString: String
    
    var textViewHasText: Bool = false
    var textFieldWidth: CGFloat = 0
    
//    init(step: Int, content: String) {
//        self.step = step
//        self.contentString = content
//        super.init()
//    }
    
//    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    lazy var backButton: BackButton = {
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
    private lazy var progressImageView = UIImageView(image: ImageLiterals.imgProgress5)
    private lazy var currentStepLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addFeedbackContentViewControllerCurrentStepLabel5
        label.textColor = .black100
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.numberOfLines = 2
        return label
    }()
    private lazy var textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    private lazy var keywordTextField: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = .gray300
        textField.attributedPlaceholder = NSAttributedString(
            string: "키워드를 입력하세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray300,
                NSAttributedString.Key.font: UIFont.main
            ]
        )
        textFieldWidth = textField.intrinsicContentSize.width
        return textField
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = "다음"
        // FIXME: 이전 PR 머지되면 아래 코드로 바꾸기
//        button.title = TextLiteral.addFeedbackContentViewControllerButtonNext
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
        setupDelegate()
        setTextFieldObserver()
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
        
        view.addSubview(textFieldContainerView)
        textFieldContainerView.snp.makeConstraints {
            $0.top.equalTo(currentStepLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(100)
            $0.height.equalTo(Size.keywordTextFieldHeight)
        }
        
        textFieldContainerView.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(13)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-2)
            $0.centerX.equalToSuperview()
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
        keywordTextField.delegate = self
    }
    
    private func setTextFieldObserver() {
        keywordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    func didTappedDoneButton() {
        DispatchQueue.main.async {
            // FIXME: done button 눌렀을 때 action -> API, View 내리기
        }
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 10)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
        })
    }
    
    @objc private func textFieldDidChange() {
        textFieldWidth = keywordTextField.intrinsicContentSize.width
        textFieldContainerView.snp.updateConstraints {
            $0.width.equalTo(textFieldWidth + Size.initialTextFieldWidth)
        }
    }
}

extension AddFeedbackKeywordViewController: UITextFieldDelegate {
    
}
