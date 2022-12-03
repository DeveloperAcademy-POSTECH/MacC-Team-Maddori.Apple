//
//  SendFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/03.
//

import UIKit

import Alamofire
import SnapKit

class SendFeedbackViewController: BaseViewController {
    
    enum Size {
        static let topPadding: Int = 8
        static let stepTopPadding: Int = 24
        static let descriptionTopPadding: Int = 12
        static let buttonViewHeight: Int = 72
    }
    var step: Int
    var contentString: String?
    
    var keyboardSize: CGRect = .zero
    
    init(step: Int, content: String?) {
        self.step = step
        self.contentString = content
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        switch step {
        case 2:
            return UIImageView(image: ImageLiterals.imgProgress2)
        case 3:
            return UIImageView(image: ImageLiterals.imgProgress3)
        case 4:
            return UIImageView(image: ImageLiterals.imgProgress4)
        default:
            return UIImageView(image: ImageLiterals.imgProgressEmpty)
        }
    }()
    private lazy var currentStepLabel: UILabel = {
        let label = UILabel()
        switch step {
        case 2:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepLabel2
        case 3:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepLabel3
        case 4:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepLabel4
        default:
            label.text = ""
        }
        label.textColor = .black100
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.numberOfLines = 2
        return label
    }()
    private lazy var currentStepDescriptionLabel: UILabel = {
        let label = UILabel()
        switch step {
        case 2:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepDescriptionLabel2
        case 3:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepDescriptionLabel3
        case 4:
            label.text = TextLiteral.sendFeedbackViewControllerCurrentStepDescriptionLabel4
        default:
            label.text = ""
        }
        label.textColor = .gray400
        label.font = .body2
        label.setLineSpacing(to: 4)
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
        // FIXME: 추가해야할게 있다면 여기에~
        view.backgroundColor = .white200
        view.font = .body1
        return view
    }()
    private let doneButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white200
        return view
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.sendFeedbackViewControllerButtonNext
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feedbackContentTextView.becomeFirstResponder()
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
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegate() {
        feedbackContentTextView.delegate = self
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    func didTappedDoneButton() {
        // FIXME: 다음 view로 연결
    }
    
    // MARK: - selector
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)

            self.feedbackContentTextView.snp.updateConstraints {
                $0.bottom.equalTo(self.doneButton.snp.top).offset(-keyboardSize.height + 15)
            }
        })
    }
    
    @objc func willHideKeyboard(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
            
            self.feedbackContentTextView.snp.updateConstraints {
                $0.bottom.equalTo(self.doneButton.snp.top).offset(-10)
            }
        })
    }
}

extension SendFeedbackViewController: UITextViewDelegate {
    
}
