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
        label.numberOfLines = 0
        label.setLineSpacing()
        return label
    }()
    private let memberCollectionView = MemberCollectionView()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = "모든 회고 끝내기 (\(memberCollectionView.numOfSelectedMember)/\(memberCollectionView.memberList.count))"
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(selectFeedbackMemberTitleLabel)
        selectFeedbackMemberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectFeedbackMemberTitleLabel.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.bottomPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
