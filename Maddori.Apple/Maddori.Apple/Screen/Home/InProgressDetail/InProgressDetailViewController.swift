//
//  ReflectionInfoViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class InProgressDetailViewController: BaseViewController {
    
    let feedbackInfo: ReflectionInfoModel
    
    init(feedbackInfo: ReflectionInfoModel) {
        self.feedbackInfo = feedbackInfo
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var keywordTitleLabel: UILabel = {
        let label = UILabel()
        let keyword = feedbackInfo.keyword
        label.setTitleFont(text: keyword)
        label.textColor = .black100
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
        let feedbackType = feedbackInfo.feedbackType
        label.text = feedbackType.rawValue
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
        label.text = feedbackInfo.nickname
        label.textColor = .black100
        label.font = .label3
        return label
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let feedbackScrollView = UIScrollView()
    private let feedbackContentView = UIView()
    private lazy var feedbackContentText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: feedbackInfo.info, lineHeight: 24)
        label.textColor = .black100
        label.font = .body3
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(3)
            $0.top.equalToSuperview().inset(6)
        }
        
        view.addSubview(keywordTitleLabel)
        keywordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeLabel)
        feedbackTypeLabel.snp.makeConstraints {
            $0.top.equalTo(keywordTitleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackTypeText)
        feedbackTypeText.snp.makeConstraints {
            $0.centerY.equalTo(feedbackTypeLabel.snp.centerY)
            $0.leading.equalTo(feedbackTypeLabel.snp.trailing).offset(54)
        }
        
        view.addSubview(feedbackFromLabel)
        feedbackFromLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeText.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackFromText)
        feedbackFromText.snp.makeConstraints {
            $0.centerY.equalTo(feedbackFromLabel.snp.centerY)
            $0.leading.equalTo(feedbackFromLabel.snp.trailing).offset(86)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(feedbackFromLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(feedbackScrollView)
        feedbackScrollView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        feedbackScrollView.addSubview(feedbackContentView)
        feedbackContentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }

        feedbackContentView.addSubview(feedbackContentText)
        feedbackContentText.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
}
