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
    
    private enum Size {
        static let topPadding: Int = 8
        static let stepTopPadding: Int = 24
        static let textFieldMaxCornerRadius: CGFloat = 25
        static let textFieldMinCornerRadius: CGFloat = 16
        static let textFieldHeight: CGFloat = 50
        static let textFieldMinWidth: CGFloat = 32
        static let textFieldXPadding: CGFloat = 16
    }
//    var currentStepString: String = ""
//    var contentString: String
    
    var placeholder = TextLiteral.addFeedbackKeywordViewControllerPlaceholder
    var textViewHasText: Bool = false
    var textFieldWidth: CGFloat = 0
    var placeholderWidth: CGFloat {
        let placeholder = "키워드를 입력하세요"
        let fontAttributes = [NSAttributedString.Key.font: UIFont.main]
        let width = (placeholder as NSString).size(withAttributes: fontAttributes).width
        return width
    }
    
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
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        // FIXME: TextField가 줄어들었을 경우 cornerRadius 때문에 깨짐
        view.layer.cornerRadius = Size.textFieldMaxCornerRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.13
        view.layer.shadowRadius = 4
        return view
    }()
    private lazy var keywordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
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
        button.title = TextLiteral.addFeedbackContentViewControllerButtonNext
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
            $0.width.equalTo(placeholderWidth + 2 * Size.textFieldXPadding)
            $0.height.equalTo(Size.textFieldHeight)
        }

        view.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints {
            $0.leading.equalTo(textFieldContainerView).offset(16)
            $0.top.equalTo(textFieldContainerView).offset(13)
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
        keywordTextField.addTarget(self, action: #selector(textFieldChangeBegin), for: .editingDidBegin)
        keywordTextField.addTarget(self, action: #selector(textFieldChanging), for: .allEditingEvents)
        keywordTextField.addTarget(self, action: #selector(textFieldChangeEnd), for: .editingDidEnd)
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
    
    @objc private func textFieldChangeBegin() {
        keywordTextField.placeholder = ""
        DispatchQueue.main.async {
            self.textFieldContainerView.layer.cornerRadius = Size.textFieldMinCornerRadius
        }
    }
    
    @objc private func textFieldChanging() {
        textFieldWidth = keywordTextField.intrinsicContentSize.width
        var textFieldContainerWidth: CGFloat = textFieldWidth + 2 * Size.textFieldXPadding
        var newCornerRadius: CGFloat = Size.textFieldMinCornerRadius
        if textFieldContainerWidth <= Size.textFieldHeight {
            newCornerRadius = textFieldContainerWidth / 2
        } else {
            newCornerRadius = Size.textFieldMaxCornerRadius
        }
        DispatchQueue.main.async {
            self.textFieldContainerView.layer.cornerRadius = newCornerRadius
            self.textFieldContainerView.snp.updateConstraints {
                $0.width.equalTo(self.textFieldWidth + 2 * Size.textFieldXPadding)
            }
        }
    }
    
    @objc private func textFieldChangeEnd() {
        if keywordTextField.text == "" {
            keywordTextField.placeholder = placeholder
            DispatchQueue.main.async {
                self.textFieldContainerView.snp.updateConstraints {
                    $0.width.equalTo(self.placeholderWidth + 2 * Size.textFieldXPadding)
                }
                self.textFieldContainerView.layer.cornerRadius = Size.textFieldMaxCornerRadius
            }
        }
    }
}

extension AddFeedbackKeywordViewController: UITextFieldDelegate {
    
}
