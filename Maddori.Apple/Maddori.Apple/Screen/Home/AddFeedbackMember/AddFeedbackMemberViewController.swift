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
    
    private let closeButton = CloseButton(type: .system)
    private let selectMemberLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.addFeedbackMemberViewControllerTitle)
        label.textColor = .black100
        label.numberOfLines = 0
        label.setLineSpacing(to: 4)
        return label
    }()
    private lazy var memberCollectionView: MemberCollectionView = {
        let collectionView = MemberCollectionView()
        collectionView.memberList = Member.getMemberListExceptUser()
        collectionView.didTappedMember = { [weak self] arr in
            self?.navigationController?.pushViewController(AddFeedbackContentViewController(from: "나", to: arr.last ?? "팀원"), animated: true)
        }
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButtonAction()
    }
    
    override func render() {
        view.addSubview(selectMemberLabel)
        selectMemberLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectMemberLabel.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - setup
    
    private func setupCloseButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let rightButton = makeBarButtonItem(with: closeButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = rightButton
    }
}
