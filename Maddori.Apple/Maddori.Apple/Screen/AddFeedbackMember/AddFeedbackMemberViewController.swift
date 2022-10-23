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
        label.text = TextLiteral.addFeedbackMemberViewControllerTitle
        label.font = .title
        label.textColor = .black100
        label.numberOfLines = 0
        label.setLineSpacing()
        return label
    }()
    private let memberCollectionView = MemberCollectionView()
    
    // MARK: - life cycle
    
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
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let exitButton = makeBarButtonItem(with: exitButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = exitButton
    }
}
