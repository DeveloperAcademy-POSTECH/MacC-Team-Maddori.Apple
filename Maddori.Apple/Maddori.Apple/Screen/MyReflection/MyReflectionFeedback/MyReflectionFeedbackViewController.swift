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
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let myReflectionScrollView = UIScrollView()
    private let myReflectionContentView = UIView()
    private lazy var feedbackContentText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: model.content, lineHeight: 24)
        label.textColor = .black100
        label.font = .body3
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
        view.addSubview(keywordTitleLabel)
        keywordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
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
        
        view.addSubview(myReflectionScrollView)
        myReflectionScrollView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        myReflectionScrollView.addSubview(myReflectionContentView)
        myReflectionContentView.snp.makeConstraints {
            $0.width.top.bottom.equalToSuperview()
        }

        myReflectionContentView.addSubview(feedbackContentText)
        feedbackContentText.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
