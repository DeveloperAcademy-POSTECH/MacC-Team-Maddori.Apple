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
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 34
        static let collectionVerticalSpacing: CGFloat = 20
        static let cellWidth: CGFloat = UIScreen.main.bounds.width * 0.37
        static let cellHeight: CGFloat = 140
        static let cellInteritemSpacing: CGFloat = 27
        static let cellLineSpacing: CGFloat = 20
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    var totalMemberList: [MemberDetailResponse] = [] {
        didSet { memberCollectionView.reloadData() }
    }
    
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
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumInteritemSpacing = Size.cellInteritemSpacing
        flowLayout.minimumLineSpacing = Size.cellLineSpacing
        return flowLayout
    }()
    private lazy var memberCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white200
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.register(ReflectionMemberCollectionViewCell.self, forCellWithReuseIdentifier: ReflectionMemberCollectionViewCell.className)
        return collectionView
    }()
    private let feedbackDoneButton: MainButton = {
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

    var memberItemTapPublisher = PublishSubject<MemberInfo>()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
        totalMemberList = teamMembers
    }
    
    func setButtonText(reflectionState: ReflectionState) {
        feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(reflectionState.numOfSeenMember)/\(totalMemberList.count))"
        feedbackDoneButton.isDisabled = !reflectionState.completedCurrentReflection
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

// MARK: - collectionView extension

extension SelectReflectionMemberView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = totalMemberList[indexPath.item].id, let nickname = totalMemberList[indexPath.item].nickname else { return }
        let memberInfo = MemberInfo(id: id, nickname: nickname)
        memberItemTapPublisher.onNext(memberInfo)
    }
}

extension SelectReflectionMemberView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalMemberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReflectionMemberCollectionViewCell.className, for: indexPath) as? ReflectionMemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        if let imagePath = totalMemberList[indexPath.item].profileImagePath {
            let fullImagePath = UrlLiteral.imageBaseURL + imagePath
            cell.profileImage.load(from: fullImagePath)
        }
        
        cell.nicknameLabel.text = totalMemberList[indexPath.item].nickname
        cell.roleLabel.text = totalMemberList[indexPath.item].role
                
        if let userId = totalMemberList[indexPath.item].id {
            if UserDefaultStorage.seenMemberIdList.contains(userId) { cell.applySelectedAttribute() }
        }
        
        return cell
    }
}
