//
//  ReflectionInfoViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class InProgressDetailViewController: BaseViewController {
    
//    let model = ReflectionInfoModel.mockData
    let feedbackInfo: ReflectionInfoModel
    
    init(feedbackInfo: ReflectionInfoModel) {
        self.feedbackInfo = feedbackInfo
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private lazy var sendFromLabel: UILabel = {
        let label = UILabel()
        label.text = "\(feedbackInfo.nickname)님이 보낸 \(feedbackInfo.feedbackType.rawValue)"
        label.textColor = .gray400
        label.applyColor(to: "\(feedbackInfo.feedbackType.rawValue)", with: .blue200)
        label.font = .caption1
        return label
    }()
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.text = feedbackInfo.keyword
        label.font = .title
        label.textColor = .black100
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = feedbackInfo.info
        label.font = .body1
        label.textColor = .gray400
        label.numberOfLines = 0
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        return label
    }()
    private lazy var startView: StartSuggestionView = {
        let view = StartSuggestionView()
        view.backgroundColor = .blue100
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.setStartInfoLabel(info: model.start)
        return view
    }()
    
    // MARK: - life cycle
        
    override func render() {
        view.addSubview(sendFromLabel)
        sendFromLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(55)
        }
        
        view.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(sendFromLabel.snp.bottom).offset(10)
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(keywordLabel.snp.bottom).offset(32)
        }
        
        if !feedbackInfo.start.isEmpty {
            view.addSubview(startView)
            startView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
                $0.top.equalTo(infoLabel.snp.bottom).offset(28)
            }
        }
    }
}
