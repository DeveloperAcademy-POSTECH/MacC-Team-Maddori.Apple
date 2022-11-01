//
//  ReflectionInfoViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class ReflectionInfoViewController: BaseViewController {
    let model = ReflectionInfoModel.mockData
    
    // MARK: - property
    
    private lazy var sendFromLabel: UILabel = {
        let label = UILabel()
        label.text = "\(model.nickname)님이 보낸 \(model.feedbackType.rawValue)"
        label.textColor = .gray400
        label.applyColor(to: "\(model.feedbackType.rawValue)", with: .blue200)
        label.font = .caption1
        return label
    }()
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.text = model.keyword
        label.font = .title
        label.textColor = .black100
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = model.info
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
        
        view.addSubview(startView)
        startView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(infoLabel.snp.bottom).offset(28)
        }
    }
}
