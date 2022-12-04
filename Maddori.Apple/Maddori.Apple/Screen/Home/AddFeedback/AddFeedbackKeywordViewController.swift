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
        static let descriptionTopPadding: Int = 12
        static let buttonViewHeight: Int = 72
    }
    var step: Int
    var currentStepString: String = ""
    var contentString: String
    
    var textViewHasText: Bool = false
    
    init(step: Int, content: String) {
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
    private let keywordTextField: UITextField = {
        let textField = UITextField()
        
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
}

