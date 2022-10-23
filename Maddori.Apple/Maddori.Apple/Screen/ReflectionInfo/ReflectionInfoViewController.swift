//
//  ReflectionInfoViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class ReflectionInfoViewController: BaseViewController {
    let viewModel: ReflectionInfoModel
    
    // MARK: - property
    
    private lazy var sendFromLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.nickname)님이 보낸 \(viewModel.feedbackType.rawValue)"
        label.textColor = .gray400
        label.applyColor(to: "\(viewModel.feedbackType.rawValue)", with: .blue200)
        label.font = .caption1
        return label
    }()
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.keyword
        label.font = .title
        label.textColor = .black100
        return label
    }()
    
    // MARK: - life cycle
    
    init(viewModel: ReflectionInfoModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        view.addSubview(sendFromLabel)
        sendFromLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide
                .snp.top).inset(55)
        }
        
        view.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(sendFromLabel.snp.bottom).offset(10)
        }
    }
}
