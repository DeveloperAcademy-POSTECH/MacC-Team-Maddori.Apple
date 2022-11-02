//
//  FeedbackFromMeDetailViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/02.
//

import UIKit

import SnapKit

final class FeedbackFromMeDetailViewController: BaseViewController {
    
    var toNickname: String = "진저"
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.red100, for: .normal)
        button.titleLabel?.font = .label2
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return button
    }()
    private let feedbackFromMeDetailScrollView = UIScrollView()
    private let feedbackFromMeDetailContentView = UIView()
    private lazy var feedbackFromMeDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: toNickname + "님께 작성한 피드백")
        label.textColor = .black100
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(feedbackFromMeDetailScrollView)
        feedbackFromMeDetailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        feedbackFromMeDetailScrollView.addSubview(feedbackFromMeDetailContentView)
        feedbackFromMeDetailContentView.snp.makeConstraints {
            $0.edges.equalTo(feedbackFromMeDetailScrollView.snp.edges)
            $0.width.equalTo(feedbackFromMeDetailScrollView.snp.width)
            $0.height.equalTo(view.frame.height)
        }
        
        feedbackFromMeDetailContentView.addSubview(feedbackFromMeDetailTitleLabel)
        feedbackFromMeDetailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackFromMeDetailContentView).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        let deleteButton = makeBarButtonItem(with: deleteButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = deleteButton
    }
}
