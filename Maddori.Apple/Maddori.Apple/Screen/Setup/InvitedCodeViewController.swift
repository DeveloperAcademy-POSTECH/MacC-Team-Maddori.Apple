//
//  InvitedCodeViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/23.
//

import UIKit

import SnapKit

final class InvitedCodeViewController: BaseViewController {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: "초대코드를 공유하여\n팀원들을 초대해주세요")
        return label
    }()
    private let invitedCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "1BCDFF"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    private lazy var copyCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("코드 복사하기", for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .label2
        button.backgroundColor = .gray100
        button.layer.cornerRadius = 4
        return button
    }()
    private lazy var startButton: MainButton = {
        let button = MainButton()
        button.title = "시작하기"
        return button
    }()
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "초대코드는 다시 복사할 수 있습니다."
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    // MARK: - life cycle
    
    // MARK: - func
    
    override func render() {
        super.render()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(invitedCodeLabel)
        invitedCodeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(copyCodeButton)
        copyCodeButton.snp.makeConstraints {
            $0.top.equalTo(invitedCodeLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(124)
            $0.height.equalTo(35)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
    }
}
