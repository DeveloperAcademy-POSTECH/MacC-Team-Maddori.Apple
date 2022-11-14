//
//  FeedbackToMeDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class FeedbackToMeDetailViewController: BaseViewController {
    
    // FIXME: - api 연결
    let model = FeedbackToMeModel.mockData
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let myReflectionScrollView = UIScrollView()
    private let myReflectionContentView = UIView()
    private lazy var keywordTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: model.keyword)
        label.textColor = .black100
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackToMeDetailViewControllerFeedbackTypeLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackTypeText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.feedbackType.rawValue, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackFromLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackToMeDetailViewControllerFeedbackFromLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackFromText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.from, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackToMeDetailViewControllerFeedbackContentLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var feedbackContentText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.content, lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    private let feedbackStartLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackToMeDetailViewControllerFeedbackStartLabel
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
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setupStartLabel()
    }
    
    override func render() {
        view.addSubview(myReflectionScrollView)
        myReflectionScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myReflectionScrollView.addSubview(myReflectionContentView)
        myReflectionContentView.snp.makeConstraints {
            $0.edges.equalTo(myReflectionScrollView.snp.edges)
            $0.width.equalTo(myReflectionScrollView.snp.width)
            $0.height.equalTo(myReflectionScrollView.snp.height).offset(50)
        }
        
        myReflectionContentView.addSubview(keywordTitleLabel)
        keywordTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(keywordTitleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackTypeText)
        feedbackTypeText.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackFromLabel)
        feedbackFromLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackFromText)
        feedbackFromText.snp.makeConstraints {
            $0.top.equalTo(feedbackFromLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackContentLabel)
        feedbackContentLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackFromText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackContentText)
        feedbackContentText.snp.makeConstraints {
            $0.top.equalTo(feedbackContentLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackStartLabel)
        feedbackStartLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackContentText.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackStartText)
        feedbackStartText.snp.makeConstraints {
            $0.top.equalTo(feedbackStartLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupStartLabel() {
        if model.start == nil {
            feedbackStartLabel.isHidden = true
        }
    }
}
