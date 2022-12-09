//
//  MemberCollectionView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionView: UIView {
    
    enum CollectionType {
        case addFeedback
        case progressReflection
    }
    
    var type: CollectionType
    var currentToUserId = 0
    var memberList: [MemberResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTappedMember: (([MemberResponse]) -> ())?
    var didTappedFeedBackMember: ((MemberResponse) -> ())?
    var selectedMember: MemberResponse?
    private var selectedMemberList: [MemberResponse] = []
    private enum ProgessSize {
        static let collectionHorizontalSpacing: CGFloat = 14
        static let collectionTopSpacing: CGFloat = 40
        static let cellWidth: CGFloat = 135
        static let cellHeight: CGFloat = 60
        static let collectionInsets = UIEdgeInsets(
            top: collectionTopSpacing,
            left: collectionHorizontalSpacing,
            bottom: 0,
            right: collectionHorizontalSpacing)
    }
    private enum AddFeedbackSize {
        static let collectionHorizontalSpacing: CGFloat = 20
        static let collectionTopSpacing: CGFloat = 10
        static let cellWidth: CGFloat = 133
        static let cellHeight: CGFloat = 52
        static let collectionInsets = UIEdgeInsets(
            top: collectionTopSpacing,
            left: collectionHorizontalSpacing,
            bottom: 20,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = type == CollectionType.progressReflection ? ProgessSize.collectionInsets : AddFeedbackSize.collectionInsets
        flowLayout.itemSize = CGSize(width: type == CollectionType.progressReflection ? ProgessSize.cellWidth : AddFeedbackSize.cellWidth ,
                                     height: type == CollectionType.progressReflection ? ProgessSize.cellHeight : AddFeedbackSize.cellHeight)
        flowLayout.minimumLineSpacing = 29
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white100
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    init(type: CollectionType) {
        self.type = type
        super.init(frame: .zero)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension MemberCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .addFeedback:
            selectedMember = memberList[indexPath.item]
            guard let member = selectedMember else { return }
            didTappedFeedBackMember?(member)

            guard let cell = collectionView.cellForItem(at: indexPath) as? MemberCollectionViewCell else { return }
            cell.applyAttribute()
            
        case .progressReflection:
            if !selectedMemberList.contains(where: { $0.userName == memberList[indexPath.item].userName} ) {
                selectedMemberList.append(memberList[indexPath.item])
            }
            guard let cell = collectionView.cellForItem(at: indexPath) as? MemberCollectionViewCell else { return }
            selectedMember = memberList[indexPath.item]
            guard let member = selectedMember else { return }
            cell.setupAttribute()
            didTappedMember?(selectedMemberList)
            didTappedFeedBackMember?(member)
        }
    }
}

extension MemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.className, for: indexPath) as? MemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.memberLabel.text = memberList[indexPath.item].userName
        return cell
    }
}
