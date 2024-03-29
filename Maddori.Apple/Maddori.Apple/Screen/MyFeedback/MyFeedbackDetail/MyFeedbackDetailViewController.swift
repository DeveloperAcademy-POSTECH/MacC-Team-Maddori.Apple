//
//  FeedbackFromMeDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackDetailViewController: BaseViewController {
    private let feedbackDetail: FeedbackFromMeModel
    private let reflectionDate: Date? = nil
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.myFeedbackDetailViewControllerDeleteButtonText, for: .normal)
        button.setTitleColor(.red100, for: .normal)
        button.titleLabel?.font = .label2
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let action = UIAction { [weak self] _ in
            self?.showAlertView(type: .delete, navigationViewController: self?.navigationController, reflectionId: self?.feedbackDetail.reflectionId ?? 0, feedbackId: self?.feedbackDetail.feedbackId ?? 0)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var feedbackFromMeDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: feedbackDetail.nickname + TextLiteral.myFeedbackDetailViewControllerTitleLabel)
        label.textColor = .black100
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackTypeLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackTypeText: UILabel = {
        let label = UILabel()
        label.text = feedbackDetail.feedbackType.rawValue
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackKeywordLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackKeywordLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackKeyword = FeedbackKeyword(title: feedbackDetail.keyword)
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackContentScrollView = UIScrollView()
    private lazy var feedbackContentText: UILabel = {
        let label = UILabel()
        let text = feedbackDetail.info
        label.setTextWithLineHeight(text: text, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    private let feedbackEditButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white200
        return view
    }()
    private lazy var editFeedbackUntilLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.myFeedbackDetailViewControllerBeforeReflectionLabel, lineHeight: 22)
        label.textColor = .gray400
        label.font = .body2
        return label
    }()
    private lazy var feedbackEditButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.myFeedbackDetailViewControllerEditButtonText
        button.isDisabled = false
        return button
    }()
    
    // MARK: - life cycle
    
    init(feedbackDetail: FeedbackFromMeModel) {
        self.feedbackDetail = feedbackDetail
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
        setupMainButton()
        setupIsProgressingStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func configUI() {
        super.configUI()
        setupFeedbackSendTimeLabel()
    }
    
    override func render() {
        view.addSubview(feedbackFromMeDetailTitleLabel)
        feedbackFromMeDetailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackFromMeDetailTitleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeText)
        feedbackTypeText.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackKeywordLabel)
        feedbackKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackKeyword)
        feedbackKeyword.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeyword.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackContentScrollView)
        feedbackContentScrollView.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
        }
        
        feedbackContentScrollView.addSubview(feedbackContentText)
        feedbackContentText.snp.makeConstraints {
            $0.width.top.bottom.equalToSuperview()
        }
        
        view.addSubview(feedbackEditButtonView)
        feedbackEditButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        feedbackEditButtonView.addSubview(feedbackEditButton)
        feedbackEditButton.snp.makeConstraints {
            $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(36)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackEditButtonView.addSubview(editFeedbackUntilLabel)
        editFeedbackUntilLabel.snp.makeConstraints {
            $0.bottom.equalTo(feedbackEditButton.snp.top).offset(-11)
            $0.centerX.equalTo(feedbackEditButtonView.snp.centerX)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        let deleteButton = makeBarButtonItem(with: deleteButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func setupFeedbackSendTimeLabel() {
        if let date = reflectionDate {
            if date <= Date() {
                feedbackEditButton.isHidden = true
                deleteButton.isHidden = true
                editFeedbackUntilLabel.setTextWithLineHeight(text: TextLiteral.myFeedbackDetailViewControllerReflectionIsStartedLabel, lineHeight: 22)
                editFeedbackUntilLabel.snp.remakeConstraints {
                    $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(44)
                    $0.centerX.equalTo(feedbackEditButtonView.snp.centerX)
                }
            } else {
                editFeedbackUntilLabel.setTextWithLineHeight(text: TextLiteral.myFeedbackDetailViewControllerBeforeReflectionLabel, lineHeight: 22)
            }
        }
    }
    
    private func setupIsProgressingStatus() {
        if feedbackDetail.reflectionStatus == .Progressing {
            navigationItem.setRightBarButton(nil, animated: false)
            
            editFeedbackUntilLabel.setTextWithLineHeight(text: TextLiteral.myFeedbackDetailViewControllerBeforeReflectionLabelNotBefore, lineHeight: 22)
            feedbackEditButton.isDisabled = true
        }
    }
    
    // MARK: - setup
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
            self?.tabBarController?.tabBar.isHidden = false
        }
        backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupMainButton() {
        let action = UIAction { [weak self ] _ in
            if let feedbackDetail = self?.feedbackDetail {
                let viewController = UINavigationController(rootViewController: MyFeedbackEditViewController(
                    feedbackDetail: feedbackDetail,
                    parentNavigationViewController: self?.navigationController ?? UINavigationController(),
                    to: feedbackDetail.nickname
                ))
                viewController.modalPresentationStyle = .fullScreen
                self?.present(viewController, animated: true)
            }
        }
        feedbackEditButton.addAction(action, for: .touchUpInside)
    }
}
