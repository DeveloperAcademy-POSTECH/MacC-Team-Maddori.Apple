//
//  AddFeedbackContentViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class AddFeedbackContentViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton()
    private let exitButton = ExitButton()
    private let addFeedbackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "진저님께 피드백 보내기"
        label.textColor = .black100
        label.font = .title
        return label
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        view.addSubview(addFeedbackTitleLabel)
        addFeedbackTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.leadingTrailingPadding)
        }
    }

    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        let exitButton = makeBarButtonItem(with: exitButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = exitButton
    }
}
