//
//  AddFeedbackMemberViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/18.
//

import UIKit

import SnapKit

final class AddFeedbackMemberViewController: BaseViewController {

    // MARK: - property
    
    private let exitButton = ExitButton()
    private let selectMemberLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백을 주고 싶은\n팀원을 선택해주세요"
        label.font = .title
        label.textColor = .black100
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 4)
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(selectMemberLabel)
        selectMemberLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let exitButton = makeBarButtonItem(with: exitButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = exitButton
    }
    
}
