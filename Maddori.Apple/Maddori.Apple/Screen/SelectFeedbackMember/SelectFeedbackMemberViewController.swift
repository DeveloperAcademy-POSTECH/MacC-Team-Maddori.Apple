//
//  SelectFeedbackMemberViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/25.
//

import UIKit

import SnapKit

final class SelectFeedbackMemberViewController: BaseViewController {
    
    // MARK: - property
    
    private let exitButton = ExitButton(type: .system)
    private let selectFeedbackMemberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백을 듣고 싶은\n팀원을 선택해주세요"
        label.textColor = .black100
        label.font = .title
        label.numberOfLines = 2
        label.setLineSpacing()
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(selectFeedbackMemberTitleLabel)
        selectFeedbackMemberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let exitButton = makeBarButtonItem(with: exitButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = exitButton
    }
}
