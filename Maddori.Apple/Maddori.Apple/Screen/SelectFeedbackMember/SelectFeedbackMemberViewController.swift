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
    
    private let exitButton = CloseButton(type: .system)
    private let selectFeedbackMemberTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.setTitleFont(text: TextLiteral.selectFeedbackMemberViewControllerTitleLabel)
        return label
    }()
    private let memberCollectionView = MemberCollectionView()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.selectFeedbackMemberViewControllerDoneButtonText + "(0/\(memberCollectionView.memberList.count))"
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedMember()
    }
    
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
    
    private func didTappedMember() {
        memberCollectionView.didTappedMember = { [weak self] member in
            self?.feedbackDoneButton.title = TextLiteral.selectFeedbackMemberViewControllerDoneButtonText + "(\(member.count)/\(self?.memberCollectionView.memberList.count ?? 0))"
            if member.count == self?.memberCollectionView.memberList.count {
                self?.feedbackDoneButton.isDisabled = false
            }
        }
    }
}
