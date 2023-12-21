//
//  SelectReflectionMemberView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2023/12/20.
//

import UIKit

import RxSwift
import RxCocoa

final class SelectReflectionMemberView: UIView {
    
    // MARK: - ui components
    
    private let closeButton = CloseButton()
    private let selectFeedbackMemberTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.setTitleFont(text: TextLiteral.selectReflectionMemberViewControllerTitleLabel)
        return label
    }()
    private let reflectionGuidelineLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.selectReflectionMemberViewControllerSubtitleLabel
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    let memberCollectionView = ReflectionMemberCollectionView()
    let feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        return button
    }()
    
    // MARK: - publisher
    
    var closeButtonTapPublisher: Observable<Void> {
        return closeButton.rx.tap.asObservable()
    }
    
    var feedbackDoneButtonTapPublisher: Observable<Void> {
        return feedbackDoneButton.rx.tap.asObservable()
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - private func
    
    // MARK: - public func
    
    func setupNavigationController(_ navigation: UINavigationController) {
        navigation.navigationBar.prefersLargeTitles = false
    }
    
    func setupNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setTeamMembers(teamMembers: [MemberDetailResponse]) {
        memberCollectionView.memberList = teamMembers
        feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(memberCollectionView.selectedMemberList.count)/\(memberCollectionView.memberList.count))"
    }
}

// MARK: - setup layout

extension SelectReflectionMemberView {
    
    private func setupLayout() {
        [selectFeedbackMemberTitleLabel, reflectionGuidelineLabel, feedbackDoneButton, memberCollectionView].forEach {
            self.addSubview($0)
        }

        selectFeedbackMemberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        reflectionGuidelineLabel.snp.makeConstraints {
            $0.top.equalTo(selectFeedbackMemberTitleLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(SizeLiteral.bottomPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(reflectionGuidelineLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(feedbackDoneButton.snp.top).inset(-6)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
