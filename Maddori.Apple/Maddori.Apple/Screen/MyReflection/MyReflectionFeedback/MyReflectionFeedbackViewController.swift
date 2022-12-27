//
//  FeedbackToMeDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class MyReflectionFeedbackViewController: BaseViewController {
    
    let model: FeedBackResponse
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let myReflectionScrollView = UIScrollView()
    private let myReflectionContentView = UIView()
    private lazy var keywordTitleLabel: UILabel = {
        let label = UILabel()
        if let keyword = model.keyword {
            label.setTitleFont(text: keyword)
            label.textColor = .black100
        }
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.myReflectionFeedbackViewControllerFeedbackTypeLabel
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private lazy var feedbackTypeText: UILabel = {
        let label = UILabel()
        label.text = model.type
        label.textColor = .black100
        label.font = .label3
        return label
    }()
    private let feedbackFromLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.myReflectionFeedbackViewControllerFeedbackFromLabel
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private lazy var feedbackFromText: UILabel = {
        let label = UILabel()
        label.text = model.fromUser?.userName ?? TextLiteral.myReflectionViewControllerDeleteUserTitle
        label.textColor = .black100
        label.font = .label3
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.myReflectionFeedbackViewControllerFeedbackContentLabel
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
    
    // MARK: - life cycle
    
    init(model: FeedBackResponse) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        view.addSubview(myReflectionScrollView)
        myReflectionScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myReflectionScrollView.addSubview(myReflectionContentView)
        myReflectionContentView.snp.makeConstraints {
            $0.width.top.bottom.equalToSuperview()
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
            $0.centerY.equalTo(feedbackTypeLabel.snp.centerY)
            $0.leading.equalTo(feedbackTypeLabel.snp.trailing).offset(54)
        }
        
        myReflectionContentView.addSubview(feedbackFromLabel)
        feedbackFromLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeText.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        myReflectionContentView.addSubview(feedbackFromText)
        feedbackFromText.snp.makeConstraints {
            $0.centerY.equalTo(feedbackFromLabel.snp.centerY)
            $0.leading.equalTo(feedbackFromLabel.snp.trailing).offset(86)
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
}
