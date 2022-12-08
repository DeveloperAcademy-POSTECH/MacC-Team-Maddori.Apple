//
//  AddDetailFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailFeedbackViewController: BaseViewController {
    
    // MARK: - property
    
    private let closeButton = CloseButton()
    // FIXME(이드 PR 합쳐지면 이미지 변경 예정)
    private let progressImageView = UIImageView(image: UIImage(systemName: "heart"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 줄 멤버와 종류를\n선택해주세요"
        label.numberOfLines = 0
        // FIXME: 이드꺼 머지되면 .title2 로 변경 예정
        label.font = .font(.bold, ofSize: 24)
        return label
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        // FIXME: 텍스트 리터럴 처리하기
        button.title = "다음"
        return button
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    override func render() {
        
        view.addSubview(progressImageView)
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(110)
            $0.height.equalTo(14)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
    }
    
    // MARK: - func
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
}
