//
//  FeedbackFromMeDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/02.
//

import UIKit

import SnapKit

final class FeedbackFromMeDetailViewController: BaseViewController {
    
    // FIXME: - 추후 API 연결 (현재는 mock data)
    
    private let model = FeedbackFromMeModel.mockData
    private let reflectionDate: Date? = nil
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.feedbackFromMeDetailViewControllerDeleteButtonText, for: .normal)
        button.setTitleColor(.red100, for: .normal)
        button.titleLabel?.font = .label2
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let action = UIAction { [weak self] _ in
            self?.didTappedDeleteButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let feedbackFromMeDetailScrollView = UIScrollView()
    private let feedbackFromMeDetailContentView = UIView()
    private lazy var feedbackFromMeDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: model.nickname + TextLiteral.feedbackFromMeDetailViewControllerTitleLabel)
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
        label.text = model.feedbackType.rawValue
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
    private lazy var feedbackKeywordText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.keyword, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackContentText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.info, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    private let feedbackStartLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackFromMeDetailViewControllerFeedbackStartLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackStartText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.start, lineHeight: 24)
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
        label.text = TextLiteral.feedbackFromMeDetailViewControllerBeforeReflectionLabel
        label.textColor = .gray400
        label.font = .body2
        return label
    }()
    private lazy var feedbackEditButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.feedbackFromMeDetailViewControllerEditButtonText
        button.isDisabled = false
        return button
    }()
    private let deleteAlertView: AlertView = {
        let view = AlertView()
        view.title = TextLiteral.feedbackFromMeDetailViewControllerAlertViewTitle
        view.subTitle = TextLiteral.feedbackFromMeDetailViewControllerAlertViewSubTitle
        view.alertType = .delete
        view.isHidden = true
        return view
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setupFeedbackSendTimeLabel()
        setupOptionalComponents()
        setupDelegate()
    }
    
    override func render() {
        view.addSubview(feedbackFromMeDetailScrollView)
        feedbackFromMeDetailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        feedbackFromMeDetailScrollView.addSubview(feedbackFromMeDetailContentView)
        feedbackFromMeDetailContentView.snp.makeConstraints {
            $0.edges.equalTo(feedbackFromMeDetailScrollView.snp.edges)
            $0.width.equalTo(feedbackFromMeDetailScrollView.snp.width)
            $0.height.equalTo(view.frame.height)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackFromMeDetailTitleLabel)
        feedbackFromMeDetailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackFromMeDetailContentView).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackFromMeDetailTitleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackTypeText)
        feedbackTypeText.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackKeywordLabel)
        feedbackKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackKeywordText)
        feedbackKeywordText.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackKeywordText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackContentText)
        feedbackContentText.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackStartLabel)
        feedbackStartLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackContentText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackStartText)
        feedbackStartText.snp.makeConstraints {
            $0.top.equalTo(feedbackStartLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackEditButtonView)
        feedbackEditButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        feedbackEditButtonView.addSubview(feedbackEditButton)
        feedbackEditButton.snp.makeConstraints {
            $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(44)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackEditButtonView.addSubview(editFeedbackUntilLabel)
        editFeedbackUntilLabel.snp.makeConstraints {
            $0.bottom.equalTo(feedbackEditButton.snp.top).offset(-11)
            $0.centerX.equalTo(feedbackEditButtonView.snp.centerX)
        }
        
        view.addSubview(deleteAlertView)
        deleteAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
                editFeedbackUntilLabel.setTextWithLineHeight(text: TextLiteral.feedbackFromMeDetailViewControllerReflectionIsStartedLabel, lineHeight: 22)
                editFeedbackUntilLabel.snp.remakeConstraints {
                    $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(44)
                    $0.centerX.equalTo(feedbackEditButtonView.snp.centerX)
                }
            } else {
                editFeedbackUntilLabel.setTextWithLineHeight(text: TextLiteral.feedbackFromMeDetailViewControllerBeforeReflectionLabel, lineHeight: 22)
            }
        }
    }

    private func setupOptionalComponents() {
        if model.start == nil {
            feedbackStartLabel.isHidden = true
            feedbackStartText.isHidden = true
        }
    }
    
    private func didTappedDeleteButton() {
        navigationController?.isNavigationBarHidden = true
        
        feedbackFromMeDetailTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(feedbackFromMeDetailContentView).inset(56)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        deleteAlertView.isHidden = false
    }
    
    private func setupDelegate() {
        deleteAlertView.delegate = self
    }
}

// MARK: - extension

extension FeedbackFromMeDetailViewController: CustomAlertDelegate {
    func action() {
        
        // FIXME: - 피드백 삭제 api 연결 + MyBoxView 로 navigate
        
        deleteAlertView.isHidden = true
        navigationController?.isNavigationBarHidden = false
        feedbackFromMeDetailTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(feedbackFromMeDetailContentView).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    func cancel() {
        deleteAlertView.isHidden = true

        navigationController?.isNavigationBarHidden = false
        
        feedbackFromMeDetailTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(feedbackFromMeDetailContentView).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
}