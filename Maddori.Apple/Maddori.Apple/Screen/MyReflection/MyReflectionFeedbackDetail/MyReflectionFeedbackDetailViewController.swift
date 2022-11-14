//
//  MyReflectionFeedbackDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class MyReflectionFeedbackDetailViewController: BaseViewController {
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let myReflectionScrollView: UIScrollView()
    private let myReflectionContentView = UIView()
    private let keywordTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: "진저는")
        label.textColor = .black100
        return label
    }()
    private let feedbackTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 종류"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackTypeText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "Continue", lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackFromLabel: UILabel = {
        let label = UILabel()
        label.text = "작성자"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackFromText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "메리", lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let feedbackContentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackContentText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요 며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요", lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    private let feedbackStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let feedbackStartText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요 며칠 전에 회의했을 때 되게 정신 없었는데 회의가 막힐 때 진행을 잘해요", lineHeight: 24)
        label.textColor = .gray400
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
    
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
}
