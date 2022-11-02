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
    private let feedbackDate: Date? = nil
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.red100, for: .normal)
        button.titleLabel?.font = .label2
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        return button
    }()
    private let feedbackFromMeDetailScrollView = UIScrollView()
    private let feedbackFromMeDetailContentView = UIView()
    private lazy var feedbackFromMeDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: model.nickname + "님께 작성한 피드백")
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
    private lazy var feedbackTypeLabelView: FeedbackTypeLabelView = {
        let view = FeedbackTypeLabelView()
        view.feedbackType = model.feedbackType
        return view
    }()
    private let feedbackKeywordLabel: UILabel = {
        let label = UILabel()
        label.text = "키워드"
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
        label.text = "내용"
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
        label.text = "Start"
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
    private lazy var feedbackSendTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .body2
        return label
    }()
    private lazy var feedbackEditButton: MainButton = {
        let button = MainButton()
        button.title = "수정하러 가기"
        button.isDisabled = false
        return button
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        
        if let date = feedbackDate {
            if date <= Date() {
                feedbackEditButton.isHidden = true
                deleteButton.isHidden = true
                feedbackSendTimeLabel.setTextWithLineHeight(text: "회고가 시작되었습니다", lineHeight: 22)
                feedbackSendTimeLabel.snp.remakeConstraints {
                    $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(91)
                    $0.centerX.equalTo(feedbackEditButtonView.snp.centerX)
                }
            } else {
                feedbackSendTimeLabel.setTextWithLineHeight(text: "담아둔 피드백은 \(date.dateToMonthDayString)에 자동으로 제출됩니다", lineHeight: 22)
            }
        } else {
            feedbackSendTimeLabel.setTextWithLineHeight(text: "담아둔 피드백은 회고 시간에 자동 제출됩니다", lineHeight: 22)
        }
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
        
        feedbackFromMeDetailContentView.addSubview(feedbackTypeLabelView)
        feedbackTypeLabelView.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(46)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackKeywordLabel)
        feedbackKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTypeLabelView.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
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
            $0.height.equalTo(181)
        }
        
        feedbackEditButtonView.addSubview(feedbackEditButton)
        feedbackEditButton.snp.makeConstraints {
            $0.bottom.equalTo(feedbackEditButtonView.snp.bottom).inset(91)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackEditButtonView.addSubview(feedbackSendTimeLabel)
        feedbackSendTimeLabel.snp.makeConstraints {
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
}
